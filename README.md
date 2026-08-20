# Homebrew-Mopidy

Homebrew formulas for installing the [Mopidy](https://mopidy.com/) music
server and a selection of Mopidy extensions on macOS, with all required
Python and non-Python dependencies.

## Installation

```sh
brew tap mopidy/mopidy
brew install mopidy
```

Then install the extensions you want, for example:

```sh
brew install mopidy-mpd mopidy-local
```

To run Mopidy as a background service that starts at login:

```sh
brew services start mopidy
```

Or run it directly in a terminal with `mopidy`.

### Available formulas

| Formula | Description |
| --- | --- |
| `mopidy` | The Mopidy music server itself |
| `mopidy-api-explorer` | HTTP API explorer |
| `mopidy-beets` | Beets backend |
| `mopidy-internetarchive` | Internet Archive backend |
| `mopidy-listenbrainz` | ListenBrainz scrobbler |
| `mopidy-local` | Local music library backend |
| `mopidy-mpd` | MPD protocol frontend |
| `mopidy-nad` | NAD amplifier control |
| `mopidy-orfradio` | ORF Austrian radio backend |
| `mopidy-pandora` | Pandora backend |
| `mopidy-pibox` | Party jukebox web client |
| `mopidy-podcast` | Podcast backend |
| `mopidy-podcast-itunes` | Apple iTunes Store podcast directory |
| `mopidy-scrobbler` | Last.fm scrobbler |
| `mopidy-somafm` | SomaFM backend |
| `mopidy-soundcloud` | SoundCloud backend |
| `mopidy-spotify` | Spotify backend |

Other Mopidy extensions from PyPI can be installed into Mopidy's
virtualenv with pip, but such installs are not managed by Homebrew and
may break when the `mopidy` formula is upgraded:

```sh
$(brew --prefix mopidy)/libexec/bin/python -m pip install mopidy-somethingelse
```

## How the formulas work

This section documents the tap's architecture. Read it before changing
any formula, whether you are a human or an AI agent.

### One virtualenv per formula, joined by `.pth` files

- Every formula (`mopidy` and each extension) installs its package and
  Python-only dependencies into its own virtualenv in the formula's
  `libexec`, using Homebrew's standard
  [`Language::Python::Virtualenv`](https://docs.brew.sh/Language-Specific-Formulae)
  helper (`virtualenv_install_with_resources`).
- Mopidy discovers extensions through `mopidy.ext` entry points on
  `sys.path`, so each extension formula must get its virtualenv onto the
  `sys.path` of the *mopidy* process. This works as follows:
  1. Each extension formula writes a
     `homebrew-<formula>.pth` file into its own
     `#{prefix}/lib/python3.X/site-packages` containing
     `import site; site.addsitedir('<extension libexec site-packages>')`.
  2. `brew link` symlinks that `.pth` file into
     `$(brew --prefix)/lib/python3.X/site-packages`.
  3. Homebrew's `python@3.X` runs a `sitecustomize.py` that calls
     `site.addsitedir()` on that directory — including inside virtualenvs
     created with `--system-site-packages`, which is what the virtualenv
     helper creates by default. `addsitedir` executes the `.pth` files,
     appending every extension's site-packages to `sys.path`.
- `sys.path` order puts mopidy's own virtualenv first, so shared
  dependencies (`pykka`, etc.) resolve from the `mopidy` formula.
  Extension formulas therefore only bundle resources that mopidy itself
  does not provide.
- GStreamer and PyGObject are *not* pip-installed. They come from the
  Homebrew `gstreamer` and `pygobject3` formulas, whose bindings the
  virtualenv helper injects into mopidy's virtualenv via a
  `homebrew_deps.pth` file (see `virtualenv_create` in Homebrew's
  `Language::Python`).
- The `spotifyaudiosrc` GStreamer element needed by `mopidy-spotify` is
  bundled in Homebrew core's `gstreamer` formula (gst-plugins-rs is part
  of the monolithic gstreamer build since 1.28).

### The Python version must match gstreamer's

All formulas in this tap must depend on the **same versioned
`python@3.X` formula that Homebrew core's `gstreamer` depends on**
(check with `brew deps gstreamer | grep python@`). If they diverge:

- mopidy cannot import gstreamer's Python bindings, and
- extensions install their `.pth` files into a `lib/python3.X`
  directory that mopidy's Python never reads, so they silently
  disappear from Mopidy.

When Homebrew core moves `gstreamer` to a new Python version, update in
lockstep, in a single PR:

1. Replace `depends_on "python@3.X"` in every formula.
2. Update the hardcoded `python3.X` strings in every `def install`
   (the `Language::Python.site_packages("python3.X")` calls and the
   `.pth` comments).
3. Bump `revision` in every formula so existing users get rebuilt kegs.

## Maintenance

### Upgrading a formula to a new upstream version

The `autobump.yml` workflow runs `brew bump` daily and opens PRs for new
PyPI releases automatically. For a manual bump:

```sh
brew bump-formula-pr --version=<new-version> mopidy/mopidy/<formula>
```

If the new version changed its Python dependencies, regenerate the
`resource` blocks:

```sh
brew update-python-resources --exclude-packages=pygobject mopidy/mopidy/mopidy
```

For extension formulas, also exclude everything provided by the mopidy
formula's virtualenv:

```sh
brew update-python-resources --exclude-packages="mopidy pygobject pykka" mopidy/mopidy/<formula>
```

Caveats:

- Homebrew resolves PyPI dependencies with a release cooldown
  (`--uploaded-prior-to`), so `brew update-python-resources` fails for
  releases uploaded less than a day ago. Wait a day, or write the
  resource blocks by hand from `https://pypi.org/pypi/<pkg>/json`
  (use the sdist URL and its sha256).
- Resources must cover the *entire* transitive dependency tree (pip runs
  with `--no-deps`), except packages excluded as described above.

### Testing changes locally

```sh
brew tap mopidy/mopidy
# Point the tap at your checkout, or edit the tap checkout directly:
#   $(brew --repository)/Library/Taps/mopidy/homebrew-mopidy

brew style mopidy/mopidy
brew audit --strict --online mopidy/mopidy/<formula>
brew install --build-from-source mopidy/mopidy/<formula>
brew test mopidy/mopidy/<formula>
```

End-to-end check that extension discovery works — every installed
extension must show up as a config section:

```sh
mopidy config
```

### Adding a new extension formula

1. Copy an existing extension formula of similar complexity
   (`mopidy-somafm.rb` has no extra resources, `mopidy-beets.rb` bundles
   a dependency tree).
2. Set `desc`, `homepage`, `url` (PyPI sdist), `sha256`, and `license`.
3. Generate resources as described above, excluding `mopidy`,
   `pygobject`, and `pykka`.
4. Keep the `.pth` block in `def install`, replacing the formula name in
   the `.pth` filename.
5. Point the `test` block's `assert_match` at the extension's config
   section name (check with `mopidy config` — it is usually, but not
   always, the extension name without the `mopidy-` prefix).
6. Run the full local testing checklist above.

### Releasing (bottles)

1. Open a PR. The `tests.yml` workflow runs `brew test-bot`, which
   builds all changed formulas from source and uploads bottles as
   workflow artifacts.
2. After review, do **not** merge with the GitHub UI. Instead, run the
   `brew pr-pull` workflow (`publish.yml`) from the Actions tab with the
   PR number as input. It downloads the bottles, uploads them to a
   GitHub release, rewrites the formulas' `bottle do` blocks, and pushes
   the result to `main`.

## License

The formulas in this tap are licensed under the 2-clause BSD license,
just like Homebrew itself. See the file `LICENSE-BSD` for the license
text.
