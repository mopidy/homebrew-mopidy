require 'formula'

class Mopidy < Formula
  homepage 'http://www.mopidy.com/'
  url 'https://pypi.python.org/packages/source/M/Mopidy/Mopidy-0.19.1.tar.gz'
  sha1 '2588e17a20e747040ea1bda2879c5e3fc96fd461'
  head 'https://github.com/mopidy/mopidy.git'

  depends_on :python
  depends_on 'homebrew/versions/gst-plugins-base010' => [
    'with-libogg',
    'with-libvorbis',
    'with-theora',
  ]
  depends_on 'homebrew/versions/gst-plugins-good010' => [
    'with-flac',
    'with-jpeg',
    'with-libshout',
    'with-libsoup',
    'with-speex',
    'with-taglib',
  ]
  depends_on 'homebrew/versions/gst-plugins-bad010' => [
    'with-faad2',
    'with-libmms',
    'with-libsndfile',
  ]
  depends_on 'homebrew/versions/gst-plugins-ugly010' => [
    'with-flac',
    'with-lame',
    'with-libmms',
    'with-libvorbis',
    'with-theora',
    'with-two-lame',
  ]
  depends_on 'homebrew/versions/gst-python010'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/python-tornado'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy"
  end
end
