require 'formula'

class MopidySoundcloud < Formula
  homepage 'https://github.com/mopidy/mopidy-soundcloud'
  url 'https://pypi.python.org/packages/source/M/Mopidy-SoundCloud/Mopidy-SoundCloud-1.2.5.tar.gz'
  sha1 'b05e365c57ab89d90af80956e2804f86371459c8'
  head 'https://github.com/mopidy/mopidy-soundcloud.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'mopidy/mopidy/requests'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy_soundcloud"
  end
end
