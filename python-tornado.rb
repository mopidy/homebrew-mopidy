class PythonTornado < Formula
  desc "Python web framework and asynchronous networking library"
  homepage "http://www.tornadoweb.org/"
  url "https://pypi.python.org/packages/source/t/tornado/tornado-4.3.tar.gz"
  sha256 "c9c2d32593d16eedf2cec1b6a41893626a2649b40b21ca9c4cac4243bde2efbf"
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
