require 'formula'

class MopidyDirble < Formula
  homepage 'https://github.com/mopidy/mopidy-dirble'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-1.1.2.tar.gz'
  sha1 'd2545c6a2e1e3716ef0fa301934d9067ef2542c8'
  head 'https://github.com/mopidy/mopidy-dirble.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/pycountry'
  depends_on 'mopidy/mopidy/requests'

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  def test
    system "python", "-c", "import mopidy_dirble"
  end
end
