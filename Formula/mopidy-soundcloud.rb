class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://pypi.python.org/packages/source/M/Mopidy-SoundCloud/Mopidy-SoundCloud-2.0.2.tar.gz"
  sha256 "374bf7ab496623f787ad2905575fce52df437e953c876486e059d8cb9aecc509"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-requests"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_soundcloud"
  end
end
