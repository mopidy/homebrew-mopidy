class Requests < Formula
  homepage "http://python-requests.org/"
  url "https://pypi.python.org/packages/source/r/requests/requests-2.6.2.tar.gz"
  sha256 "0577249d4b6c4b11fd97c28037e98664bfaa0559022fee7bcef6b752a106e505"
  head "https://github.com/kennethreitz/requests.git"

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import requests"
    end
  end
end
