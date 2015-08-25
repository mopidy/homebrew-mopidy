class Requests < Formula
  homepage "http://python-requests.org/"
  url "https://pypi.python.org/packages/source/r/requests/requests-2.6.2.tar.gz"
  sha1 "fb71223cbdd4b141bb27bc69e9640f0e407b8451"
  head "https://github.com/kennethreitz/requests.git"

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, version|
      system python, "-c", "import requests"
    end
  end
end
