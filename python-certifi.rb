class PythonCertifi < Formula
  desc "Python package for providing Mozilla's CA Bundle"
  homepage "https://pypi.python.org/pypi/certifi"
  url "https://pypi.python.org/packages/source/c/certifi/certifi-2015.11.20.1.tar.gz"
  sha256 "30b0a7354a1b32caa8b4705d3f5fb2dadefac7ba4bf8af8a2176869f93e38f16"
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
