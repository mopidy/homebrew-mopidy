class PythonRequests < Formula
  desc "Python library for making HTTP requests"
  homepage "http://python-requests.org/"
  url "https://pypi.python.org/packages/8d/66/649f861f980c0a168dd4cccc4dd0ed8fa5bd6c1bed3bea9a286434632771/requests-2.11.0.tar.gz\#md5\=147afc07d8967cf46359701551a6cb69"
  sha256 "b2ff053e93ef11ea08b0e596a1618487c4e4c5f1006d7a1706e3671c57dea385"
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
