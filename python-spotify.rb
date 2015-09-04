class PythonSpotify < Formula
  desc "Python binding for libspotify"
  homepage "http://pyspotify.mopidy.com/"
  url "https://pypi.python.org/packages/source/p/pyspotify/pyspotify-2.0.3.tar.gz"
  sha256 "899bb134b9cfb34efe443194ce477c338525efd575aa4b8033393b9803fb35cb"
  head "https://github.com/mopidy/pyspotify.git", :branch => "v2.x/develop"

  depends_on :python
  depends_on "mopidy/mopidy/libspotify"
  depends_on "mopidy/mopidy/python-cffi"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import spotify"
  end
end
