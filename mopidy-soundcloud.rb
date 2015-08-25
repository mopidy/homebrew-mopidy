class MopidySoundcloud < Formula
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://pypi.python.org/packages/source/M/Mopidy-SoundCloud/Mopidy-SoundCloud-2.0.0.tar.gz"
  sha256 "cb98ec6bb8c4639b51771de552bf4a22fffb651c869dbaa46936cb8585b7b68c"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

  depends_on :python
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/pykka"
  depends_on "mopidy/mopidy/requests"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_soundcloud"
  end
end
