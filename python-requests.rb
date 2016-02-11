class PythonRequests < Formula
  desc "Python library for making HTTP requests"
  homepage "http://python-requests.org/"
  url "https://pypi.python.org/packages/source/r/requests/requests-2.9.1.tar.gz"
  sha256 "c577815dd00f1394203fc44eb979724b098f88264a9ef898ee45b8e5e9cf587f"
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
