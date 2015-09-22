class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-2.1.0.tar.gz"
  sha256 "999a89136b94d1efee154f8b35cc8dda04de8ccc813d2fe56b6bf9a7d2275c03"
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
