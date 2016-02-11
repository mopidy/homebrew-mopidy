class PythonCffi < Formula
  desc "C Foreign Function Interface for Python"
  homepage "https://cffi.readthedocs.org/"
  url "https://pypi.python.org/packages/source/c/cffi/cffi-1.5.0.tar.gz"
  sha256 "44f76f6c3fc654860821785192eca29bd66531af57d09b681e6d52584604a7e7"
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
