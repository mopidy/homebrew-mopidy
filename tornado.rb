require 'formula'

class Tornado < Formula
  homepage 'http://www.tornadoweb.org/'
  url 'https://pypi.python.org/packages/source/t/tornado/tornado-4.0.tar.gz'
  sha1 '466e73db0d9e7a030f6933346e191637ae6ddd8a'
  head 'https://github.com/tornadoweb/tornado.git'

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      system python, "setup.py", "install", "--prefix=#{prefix}",
        "--single-version-externally-managed", "--record=installed.txt"
    end
  end

  def test
    Language::Python.each_python(build) do |python, version|
      system python, "-c", "import tornado"
    end
  end
end
