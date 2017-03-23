class MopidyScrobbler < Formula
  desc "Mopidy extension for scrobbling played tracks to Last.fm"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://pypi.python.org/packages/source/M/Mopidy-Scrobbler/Mopidy-Scrobbler-1.1.1.tar.gz"
  sha256 "7951dcf4db088fe755145a16a853546fbf3cf7a408d2120d50580ed3db0a85c3"
  head "https://github.com/mopidy/mopidy-scrobbler.git"

  depends_on :python
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-pylast"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_scrobbler"
  end
end
