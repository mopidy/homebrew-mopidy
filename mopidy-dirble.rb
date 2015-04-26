require 'formula'

class MopidyDirble < Formula
  homepage 'https://github.com/mopidy/mopidy-dirble'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-1.1.0_1.tar.gz'
  sha1 '22f5739fa00c2f752b3bc42595dd4e0ee1afe512'
  head 'https://github.com/mopidy/mopidy-dirble.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/pycountry'
  depends_on 'mopidy/mopidy/requests'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy_dirble"
  end
end
