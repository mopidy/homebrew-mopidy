class MopidySpotify < Formula
  include Language::Python::Virtualenv

  desc "Spotify backend for the Mopidy music server"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/66/88/0fe5a503aae1e237c154546cd086f3a4d5c1ec8cabc63eff2c7296b21c4e/mopidy_spotify-5.0.1.tar.gz"
  sha256 "54877fec64fe2201d6dfe12a7c5815c3f3a66cacc14cd44f87fc0824c715b16e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/mopidy/homebrew-mopidy/releases/download/mopidy-spotify-5.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "abb374652f6f5d35f29bf6df0f2ab3bf0889b641854eb7f68e3474bc96cbd953"
  end

  depends_on "mopidy/mopidy/mopidy"
  # The Python version must match the mopidy formula's.
  depends_on "python@3.14"

  pypi_packages exclude_packages: "mopidy"

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83/charset_normalizer-3.5.1.tar.gz"
    sha256 "6117b84ea48435e5356dc737f5121485c30920ba43375fa7b434fd753df0eac3"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz"
    sha256 "231e0ec3b63ceb14667c67be60f2f2c40a518cb38b03af60abc813da26505f4c"
  end

  def install
    virtualenv_install_with_resources

    # Register the extension with the mopidy formula's venv: this .pth file
    # gets linked into HOMEBREW_PREFIX/lib/python3.14/site-packages, which
    # the brewed python processes at startup (also inside mopidy's venv, as
    # it is created with --system-site-packages).
    site_packages = Language::Python.site_packages("python3.14")
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write \
      "import site; site.addsitedir('#{libexec/site_packages}')\n"
  end

  test do
    mopidy = formula_opt_bin("mopidy/mopidy/mopidy")/"mopidy"
    assert_match "[spotify]", shell_output("#{mopidy} config")
  end
end
