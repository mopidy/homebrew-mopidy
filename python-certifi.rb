class PythonCertifi < Formula
  homepage "https://pypi.python.org/pypi/certifi"
  url "https://pypi.python.org/packages/source/c/certifi/certifi-14.05.14.tar.gz"
  sha256 "1e1bcbacd6357c151ae37cf0290dcc809721d32ce21fd6b7339568f3ddef1b69"
  head "https://github.com/certifi/python-certifi.git"

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import certifi"
    end
  end
end
