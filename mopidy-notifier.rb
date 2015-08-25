class MopidyNotifier < Formula
  homepage 'https://github.com/sauberfred/mopidy-notifier'
  url 'https://pypi.python.org/packages/source/M/Mopidy-Notifier/Mopidy-Notifier-0.3.3.tar.gz'
  sha1 'd5eecbc99d19b004e912a538d70f5cfad74cb417'
  head 'https://github.com/sauberfred/mopidy-notifier.git'

  depends_on :python
  depends_on 'mopidy/mopidy/mopidy'
  depends_on 'mopidy/mopidy/pykka'
  depends_on 'terminal-notifier'

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_notifier"
  end
end
