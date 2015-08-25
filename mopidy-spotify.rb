require 'formula'

class MopidySpotify < Formula
  homepage 'https://github.com/mopidy/mopidy-spotify'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Spotify/Mopidy-Spotify-1.4.0.tar.gz'
  sha1 'c32e9e2349d0186f4aff320982e80e1b1e5bfdaa'
  head 'https://github.com/mopidy/mopidy-spotify.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/pyspotify'

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  def test
    system "python", "-c", "import mopidy_spotify"
  end
end
