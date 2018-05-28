class PythonCffi < Formula
  desc "C Foreign Function Interface for Python"
  homepage "https://cffi.readthedocs.org/"
  url "https://pypi.python.org/packages/83/3c/00b553fd05ae32f27b3637f705c413c4ce71290aa9b4c4764df694e906d9/cffi-1.7.0.tar.gz"
  sha256 "6ed5dd6afd8361f34819c68aaebf9e8fc12b5a5893f91f50c9e50c8886bb60df"
  head "https://bitbucket.org/cffi/cffi", :using => :hg

  depends_on "python@2" => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => :optional
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
