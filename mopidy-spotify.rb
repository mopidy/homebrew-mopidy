require 'formula'

class MopidySpotify < Formula
  homepage 'https://github.com/mopidy/mopidy-spotify'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-1.1.3.tar.gz'
  sha1 'a5b8f290f2870ae09d48f2a3e0a658278a058934'
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
