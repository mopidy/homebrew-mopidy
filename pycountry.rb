class Pycountry < Formula
  desc "Python library for ISO country, language, currency and scripts"
  homepage "https://pypi.python.org/pypi/pycountry"
  url "https://pypi.python.org/packages/source/p/pycountry/pycountry-1.10.zip"
  sha256 "29bd07e5f0d0471c260cea14e2ca4b7d705228ebb024b4de139dc87795576e67"
  head "https://bitbucket.org/gocept/pycountry", :using => :hg

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import pycountry"
    end
  end
end
