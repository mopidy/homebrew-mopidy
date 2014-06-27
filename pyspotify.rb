require 'formula'

class Pyspotify < Formula
  homepage 'http://pyspotify.mopidy.com/'
  url 'https://pypi.python.org/packages/source/p/pyspotify/pyspotify-1.11.tar.gz'
  sha1 'e56ccbb600e653fd8bbbaa1fe502a00bb7e0a9f1'
  head 'https://github.com/mopidy/pyspotify.git', :branch => "v1.x/develop"

  depends_on :python
  depends_on 'mopidy/mopidy/libspotify'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end

  def test
    system "python", "-c", "import spotify"
  end
end
