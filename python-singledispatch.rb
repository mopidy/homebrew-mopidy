class PythonSingledispatch < Formula
  desc "Backport functools.singledispatch from Python 3.4 to Python 2.6-3.3"
  homepage "https://pypi.python.org/pypi/singledispatch"
  url "https://pypi.python.org/packages/source/s/singledispatch/singledispatch-3.4.0.3.tar.gz"
  sha256 "5b06af87df13818d14f08a028e42f566640aef80805c3b50c5056b086e3c2b9c"
  head "https://bitbucket.org/ambv/singledispatch", :using => :hg

  depends_on "python" => :recommended
  depends_on "python3" => :optional
  depends_on "mopidy/mopidy/python-six"

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import singledispatch"
    end
  end
end
