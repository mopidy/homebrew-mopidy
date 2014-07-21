require 'formula'

class MopidySpotify < Formula
  homepage 'https://github.com/mopidy/mopidy-spotify'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-1.2.0.tar.gz'
  sha1 '29bd649290cedb856192d918d53563175c63a03a'
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
