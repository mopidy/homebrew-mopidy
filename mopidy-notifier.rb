require 'formula'

class MopidyNotifier < Formula
  homepage 'https://github.com/sauberfred/mopidy-notifier'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Notifier/Mopidy-Notifier-0.3.2.tar.gz'
  sha1 'f3afe6cb2a215d1a0cd645c1e4ae85543246a0e5'
  head 'https://github.com/sauberfred/mopidy-notifier.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'terminal-notifier'

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}",
      "--record=installed.txt", "--single-version-externally-managed"
  end

  def test
    system "python", "-c", "import mopidy_notifier"
  end
end
