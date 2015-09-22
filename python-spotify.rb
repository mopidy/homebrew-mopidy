class PythonSpotify < Formula
  desc "Python binding for libspotify"
  homepage "http://pyspotify.mopidy.com/"
  url "https://pypi.python.org/packages/source/p/pyspotify/pyspotify-2.0.5.tar.gz"
  sha256 "fbd41c58d62232b0cabb7a9e38d45f36ac221699c006899bdb6be74c04602678"
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
