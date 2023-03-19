class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/28/34/b813121d65d8fbe30062380d7ff258f5d6b13030cd7fc0d64c33a9851ea5/Mopidy-Spotify-4.1.0.tar.gz"
  sha256 "9a41fc970a9b66be0c757f3817f013a7af00e4b0ef795c90343003fd86a5126f"
  head "https://github.com/mopidy/mopidy-spotify.git"

  depends_on "python@3.9"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.9"].opt_bin/"python3"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy_spotify"
  end
end
