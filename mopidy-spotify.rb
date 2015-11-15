class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-2.2.0.tar.gz"
  sha256 "8d688959d065d14acf6409cf81bc05836efcf650a154bb84b093cdd7c50b07e1"
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
