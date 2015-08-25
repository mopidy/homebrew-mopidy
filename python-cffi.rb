class PythonCffi < Formula
  desc "C Foreign Function Interface for Python"
  homepage "https://cffi.readthedocs.org/"
  url "https://pypi.python.org/packages/source/c/cffi/cffi-1.2.1.tar.gz"
  sha256 "eab571deb0a152e2f53c404c08a94870a131526896cad08cd43bf86ce3771e3d"
  head "https://bitbucket.org/cffi/cffi", :using => :hg

  depends_on :python => :recommended
  depends_on :python3 => :optional
  depends_on "libffi"

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
