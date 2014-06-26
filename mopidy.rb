require 'formula'

class Mopidy < Formula
  homepage 'http://www.mopidy.com/'
  url 'https://pypi.python.org/packages/source/M/Mopidy/Mopidy-0.18.3.tar.gz'
  sha1 '454076a044fefca94e239a1c901074ba021f178f'
  head 'https://github.com/mopidy/mopidy.git'

  depends_on :python
  depends_on 'homebrew/versions/gst-python010'
  depends_on 'homebrew/versions/gst-plugins-good010'
  depends_on 'homebrew/versions/gst-plugins-ugly010'
  depends_on 'mopidy/mopidy/pykka'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy"
  end
end
