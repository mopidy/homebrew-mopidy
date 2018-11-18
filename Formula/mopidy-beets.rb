class MopidyBeets < Formula
  desc "Mopidy extension for playing music from Beets with its web plugin"
  homepage "https://github.com/mopidy/mopidy-beets"
  url "https://files.pythonhosted.org/packages/01/f1/b5104e2fdd1cce139804bb2298dd7cdc295f7a257386cc0302cf5d794586/Mopidy-Beets-3.1.0.tar.gz"
  sha256 "bb0ad86c1ce70942a98a6d7e92efe71dbdbec411fbde7c5d8b3c745103a64a21"
  head "https://github.com/mopidy/mopidy-beets.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-beets.pth").write pth_contents
  end

  test do
    system "python", "-c", "import mopidy_beets"
  end
end
