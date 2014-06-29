require 'formula'

class MopidyDirble < Formula
  homepage 'https://github.com/mopidy/mopidy-dirble'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-0.1.1.tar.gz'
  sha1 'ef14e9c8316265d2739e4b0fe607e8f3d773ebc4'
  head 'https://github.com/mopidy/mopidy-dirble.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/pycountry'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy_dirble"
  end
end
