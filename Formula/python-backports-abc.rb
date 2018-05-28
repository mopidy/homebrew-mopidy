class PythonBackportsAbc < Formula
  desc "Backport of recent additions to the 'collections.abc' module"
  homepage "https://pypi.python.org/pypi/backports_abc"
  url "https://files.pythonhosted.org/packages/source/b/backports_abc/backports_abc-0.4.tar.gz"
  sha256 "8b3e4092ba3d541c7a2f9b7d0d9c0275b21c6a01c53a61c731eba6686939d0a5"
  head "https://github.com/cython/backports_abc"

  depends_on "python@2" => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import backports_abc"
    end
  end
end
