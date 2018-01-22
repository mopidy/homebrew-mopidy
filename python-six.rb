class PythonSix < Formula
  desc "Python 2 and 3 compatibility utilities"
  homepage "https://pypi.python.org/pypi/six"
  url "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz"
  sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  head "https://bitbucket.org/gutworth/six", :using => :hg

  depends_on "python" => :recommended
  depends_on "python3" => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import six"
    end
  end
end
