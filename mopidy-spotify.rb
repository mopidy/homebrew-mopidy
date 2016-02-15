class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-3.0.0.tar.gz"
  sha256 "441caefa0713288a10e9d6de28dec12a9c7ab2c70089cfe4f824825f37fba45f"
  head "https://github.com/mopidy/mopidy-spotify.git"

  depends_on :python
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-requests"
  depends_on "mopidy/mopidy/python-spotify"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_spotify"
  end
end
