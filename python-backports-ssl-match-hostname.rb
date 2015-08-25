class PythonBackportsSslMatchHostname < Formula
  homepage "https://pypi.python.org/pypi/backports.ssl_match_hostname"
  url "https://pypi.python.org/packages/source/b/backports.ssl_match_hostname/backports.ssl_match_hostname-3.4.0.2.tar.gz"
  sha256 "07410e7fb09aab7bdaf5e618de66c3dac84e2e3d628352814dc4c37de321d6ae"
  head "https://bitbucket.org/brandon/backports.ssl_match_hostname"

  depends_on :python => :recommended
  depends_on :python3 => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import backports.ssl_match_hostname"
    end
  end
end
