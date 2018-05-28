class PythonBackportsSslMatchHostname < Formula
  desc "Backport of ssl.match_hostname() function"
  homepage "https://pypi.python.org/pypi/backports.ssl_match_hostname"
  url "https://pypi.python.org/packages/source/b/backports.ssl_match_hostname/backports.ssl_match_hostname-3.5.0.1.tar.gz"
  sha256 "502ad98707319f4a51fa2ca1c677bd659008d27ded9f6380c79e8932e38dcdf2"
  head "https://bitbucket.org/brandon/backports.ssl_match_hostname"

  depends_on "python@2" => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => :optional

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
