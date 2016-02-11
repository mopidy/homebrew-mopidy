class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-2.3.0.tar.gz"
  sha256 "f401a83036d609da24e624446bd2820ffe1100e1a423d711241a724d7166c798"
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
