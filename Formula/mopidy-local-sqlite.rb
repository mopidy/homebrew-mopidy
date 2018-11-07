class MopidyLocalSqlite < Formula
  desc "Mopidy extension for playing music from local SQLite database"
  homepage "https://github.com/mopidy/mopidy-local-sqlite"
  url "https://files.pythonhosted.org/packages/0f/4d/f156196381ae8cea81bd3b75a493a180a137f01a568aacb77f0f5e223c08/Mopidy-Local-SQLite-1.0.0.tar.gz"
  sha256 "5207b92e049b8ec60825f18065382d46eacb9dd328cf1b227f67e6771efefc13"
  head "https://github.com/mopidy/mopidy-local-sqlite.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-local-sqlite.pth").write pth_contents
  end

  test do
    system "python", "-c", "import mopidy_local_sqlite"
  end
end
