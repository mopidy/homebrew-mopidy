class Pykka < Formula
  homepage 'http://www.pykka.org/'
  url 'https://pypi.python.org/packages/source/P/Pykka/Pykka-1.2.1.tar.gz'
  sha1 '7a9e895af8af6cb7e3115666264c58b3f5538b0a'
  head 'https://github.com/jodal/pykka.git'

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  def test
    Language::Python.each_python(build) do |python, version|
      system python, "-c", "import pykka"
    end
  end
end
