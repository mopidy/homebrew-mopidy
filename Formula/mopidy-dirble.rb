class MopidyDirble < Formula
  desc "Mopidy extension for the Dirble radio station directory"
  homepage "https://github.com/mopidy/mopidy-dirble"
  url "https://files.pythonhosted.org/packages/source/M/Mopidy-Dirble/Mopidy-Dirble-1.3.0.tar.gz"
  sha256 "ac018cb8534d2baec1981406251e1d6f00d172577554eae0783bc4ee68c94661"
  head "https://github.com/mopidy/mopidy-dirble.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-dirble.pth").write pth_contents
  end

  test do
    system "python", "-c", "import mopidy_dirble"
  end
end
