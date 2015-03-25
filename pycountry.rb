require 'formula'

class Pycountry < Formula
  homepage 'https://pypi.python.org/pypi/pycountry'
  url 'https://pypi.python.org/packages/source/p/pycountry/pycountry-1.10.zip'
  sha1 'a7dcea993898d81ae23985d3c0d3a415be59b038'
  head 'https://bitbucket.org/gocept/pycountry', :using => :hg

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
      system python, "-c", "import pycountry"
    end
  end
end
