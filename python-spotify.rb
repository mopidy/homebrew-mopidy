class PythonSpotify < Formula
  desc "Python binding for libspotify"
  homepage "http://pyspotify.mopidy.com/"
  url "https://pypi.python.org/packages/source/p/pyspotify/pyspotify-1.12.tar.gz"
  sha256 "0f2e80194c3bb700ea65bc3d311a58bbab1909df07a396513f72d97a259e2d34"
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
