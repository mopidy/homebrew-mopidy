require 'formula'

class Pykka < Formula
  homepage 'http://www.pykka.org/'
  url 'https://pypi.python.org/packages/source/P/Pykka/Pykka-1.2.0.tar.gz'
  sha1 '566f9281f597a4254ed8c9360b30e0d82891585b'
  head 'https://github.com/jodal/pykka.git'

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      system python, "setup.py", "install", "--prefix=#{prefix}"
        # XXX This will be needed with the next release of Pykka, since it
        # switches from distutils to setuptools.
        #"--single-version-externally-managed", "--record=installed.txt"
    end
  end

  def test
    Language::Python.each_python(build) do |python, version|
      system python, "-c", "import pykka"
    end
  end
end
