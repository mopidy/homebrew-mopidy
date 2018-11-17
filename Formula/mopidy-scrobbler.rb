class MopidyScrobbler < Formula
  desc "Mopidy extension for scrobbling played tracks to Last.fm"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://files.pythonhosted.org/packages/23/f0/f9c4766e14d8ff4196df78118fe91743a467a50c3b5ac072a4c9a5cf24ad/Mopidy-Scrobbler-1.2.0.tar.gz"
  sha256 "47ee27fab12cd12d8e837bc97aaf46cfae00eaccc37c8b44ac4254b0f0615909"
  head "https://github.com/mopidy/mopidy-scrobbler.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka

  resource "pylast" do
    url "https://files.pythonhosted.org/packages/8a/1a/ece4ef4ebf51236ac25e9708fb3e1e70b6447e01262f8b156ccbda894fa9/pylast-2.2.0.tar.gz"
    sha256 "a21a10e559cbb80db5eb72e20a22740496a292977ed3568c937560b8d6885ab4"
  end

  def install
    resource("pylast").stage do
      system "python", *Language::Python.setup_install_args(libexec)
    end

    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-scrobbler.pth").write pth_contents
  end

  test do
    system "python", "-c", "import mopidy_scrobbler"
  end
end
