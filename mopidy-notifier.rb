require 'formula'

class MopidyNotifier < Formula
  homepage 'https://github.com/sauberfred/mopidy-notifier'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Notifier/Mopidy-Notifier-0.3.0.tar.gz'
  sha1 'ee71ef9645276703d90d27983bf60156b1b774ca'
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
