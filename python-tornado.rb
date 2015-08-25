class PythonTornado < Formula
  homepage "http://www.tornadoweb.org/"
  url "https://pypi.python.org/packages/source/t/tornado/tornado-4.1.tar.gz"
  sha256 "99abd3aede45c93739346ee7384e710120121c3744da155d5cff1c0101702228"
  head "https://github.com/tornadoweb/tornado.git"

  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on "mopidy/mopidy/python-backports-ssl-match-hostname"
  depends_on "mopidy/mopidy/python-certifi"

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
