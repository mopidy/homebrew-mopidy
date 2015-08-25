class PythonSpotify < Formula
  desc "Python binding for libspotify"
  homepage "http://pyspotify.mopidy.com/"
  url "https://pypi.python.org/packages/source/p/pyspotify/pyspotify-2.0.2.tar.gz"
  sha256 "46211fcf7746de027515ecf2c41cd779c5fe7f9103fce52cff33f3726c3bc8b5"
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
