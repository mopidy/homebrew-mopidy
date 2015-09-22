class PythonRequests < Formula
  desc "Python library for making HTTP requests"
  homepage "http://python-requests.org/"
  url "https://pypi.python.org/packages/source/r/requests/requests-2.7.0.tar.gz"
  sha256 "398a3db6d61899d25fd4a06c6ca12051b0ce171d705decd7ed5511517b4bb93d"
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
