require 'formula'

class PythonCertifi < Formula
  homepage 'https://pypi.python.org/pypi/certifi'
  url 'https://pypi.python.org/packages/source/c/certifi/certifi-14.05.14.tar.gz'
  sha1 'f53dc8f57aaf6d69c183ebadcec52ece0a55cc3f'
  head 'https://github.com/certifi/python-certifi.git'

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  def test
    Language::Python.each_python(build) do |python, version|
      system python, "-c", "import certifi"
    end
  end
end
