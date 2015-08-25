class MopidySoundcloud < Formula
  homepage 'https://github.com/mopidy/mopidy-soundcloud'
  url 'https://pypi.python.org/packages/source/M/Mopidy-SoundCloud/Mopidy-SoundCloud-2.0.0.tar.gz'
  sha1 '6874188c515b03b2cd4a6a64a67c9a9d098099f4'
  head 'https://github.com/mopidy/mopidy-soundcloud.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/requests'

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_soundcloud"
  end
end
