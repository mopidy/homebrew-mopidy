class PythonTornado < Formula
  desc "Python web framework and asynchronous networking library"
  homepage "http://www.tornadoweb.org/"
  url "https://pypi.python.org/packages/96/5d/ff472313e8f337d5acda5d56e6ea79a43583cc8771b34c85a1f458e197c3/tornado-4.4.1.tar.gz"
  sha256 "371d0cf3d56c47accc66116a77ad558d76eebaa8458a6b677af71ca606522146"
  head "https://github.com/tornadoweb/tornado.git"

  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on "mopidy/mopidy/python-backports-abc"
  depends_on "mopidy/mopidy/python-backports-ssl-match-hostname"
  depends_on "mopidy/mopidy/python-certifi"
  depends_on "mopidy/mopidy/python-singledispatch"

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import tornado"
    end
  end
end
