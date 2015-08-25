class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-1.4.0.tar.gz"
  sha256 "f81f3ea23af052a0b153c00714e579e10c926f1606e150b00acdc1f5ff516e2f"
  head "https://github.com/mopidy/mopidy-spotify.git"

  depends_on :python
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/pyspotify"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_spotify"
  end
end
