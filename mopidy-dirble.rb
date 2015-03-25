require 'formula'

class MopidyDirble < Formula
  homepage 'https://github.com/mopidy/mopidy-dirble'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-1.0.0.tar.gz'
  sha1 '51d42bc76e80f0c2c3aeeb2b98380e0e23bf82c7'
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
