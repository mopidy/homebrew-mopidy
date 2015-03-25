require 'formula'

class MopidySpotify < Formula
  homepage 'https://github.com/mopidy/mopidy-spotify'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-1.3.0.tar.gz'
  sha1 'feeac7e8187e3c4d4a0e8ced8bdb2c41924f6840'
  head 'https://github.com/mopidy/mopidy-spotify.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/pyspotify'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy_spotify"
  end
end
