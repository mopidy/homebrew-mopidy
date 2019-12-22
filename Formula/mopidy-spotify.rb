class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/7a/ac/18a57c7f617d954d0fdebfcec48cb5175b134389ea36ddf3b546bf0a0f83/Mopidy-Spotify-4.0.0.tar.gz"
  sha256 "21aad90ff2247d374f650d5967a8cd81028e0cc8f11316008dabeee30d61d2b8"
  head "https://github.com/mopidy/mopidy-spotify.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/pyspotify"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_spotify"
  end
end
