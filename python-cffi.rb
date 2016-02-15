class PythonCffi < Formula
  desc "C Foreign Function Interface for Python"
  homepage "https://cffi.readthedocs.org/"
  url "https://pypi.python.org/packages/source/c/cffi/cffi-1.5.2.tar.gz"
  sha256 "da9bde99872e46f7bb5cff40a9b1cc08406765efafb583c704de108b6cb821dd"
  head "https://bitbucket.org/cffi/cffi", :using => :hg

  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on "libffi"
  depends_on "mopidy/mopidy/python-pycparser"

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import cffi"
    end
  end
end
