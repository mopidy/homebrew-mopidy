require 'formula'

class PythonBackportsSslMatchHostname < Formula
  homepage 'https://pypi.python.org/pypi/backports.ssl_match_hostname'
  url 'https://pypi.python.org/packages/source/b/backports.ssl_match_hostname/backports.ssl_match_hostname-3.4.0.2.tar.gz'
  sha1 'da4e41f3b110279d2382df47ac1e4f10c63cf954'
  head 'https://bitbucket.org/brandon/backports.ssl_match_hostname'

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
      system python, "-c", "import backports.ssl_match_hostname"
    end
  end
end
