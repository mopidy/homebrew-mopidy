class Pyspotify < Formula
  homepage "http://pyspotify.mopidy.com/"
  url "https://pypi.python.org/packages/source/p/pyspotify/pyspotify-1.12.tar.gz"
  sha1 "c6421b9f9c8cd1ba013c04abfe4397aa0f1d47c2"
  head "https://github.com/mopidy/pyspotify.git", :branch => "v1.x/develop"

  depends_on :python
  depends_on "mopidy/mopidy/libspotify"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import spotify"
  end
end
