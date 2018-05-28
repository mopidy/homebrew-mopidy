class MopidyNotifier < Formula
  desc "Mopidy extension for OS X notifications"
  homepage "https://github.com/sauberfred/mopidy-notifier"
  url "https://pypi.python.org/packages/source/M/Mopidy-Notifier/Mopidy-Notifier-0.3.3.tar.gz"
  sha256 "2bb1ab9ade3633269a5b4ff765fafad5f61e1cebd74e6d0671b60b8ea7501990"
  head "https://github.com/sauberfred/mopidy-notifier.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "terminal-notifier"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy_notifier"
  end
end
