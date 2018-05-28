class PythonPykka < Formula
  desc "Python implementation of the actor model"
  homepage "https://www.pykka.org/"
  url "https://files.pythonhosted.org/packages/source/P/Pykka/Pykka-1.2.1.tar.gz"
  sha256 "e847ffeadee49b563426ab803e8eee67264d773e38ca14763fdcda56411e3c11"
  head "https://github.com/jodal/pykka.git"

  depends_on "python@2" => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import pykka"
    end
  end
end
