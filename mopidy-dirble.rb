class MopidyDirble < Formula
  desc "Mopidy extension for the Dirble radio station directory"
  homepage "https://github.com/mopidy/mopidy-dirble"
  url "https://pypi.python.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-1.1.2.tar.gz"
  sha256 "afb20a311a73e25c13cfede140bb0ceca588402d42becdd8c9afb1fd35c7a1af"
  head "https://github.com/mopidy/mopidy-dirble.git"

  depends_on :python
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-pycountry"
  depends_on "mopidy/mopidy/requests"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_dirble"
  end
end
