class MopidyTunein < Formula
  desc "Mopidy extension for playing music from TuneIn"
  homepage "https://github.com/kingosticks/mopidy-tunein"
  url "https://files.pythonhosted.org/packages/06/57/bc06f47a2d5e716b15bc3b74d859854386dd5c9ebf7d73a025c32d267945/Mopidy-TuneIn-1.0.0.tar.gz"
  sha256 "d261730b918db2d81af204ee42c40d33d73fefe9aafe0225d652214e9c56da46"
  head "https://github.com/kingosticks/mopidy-tunein.git"
  revision 1

  depends_on "python@3.8"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.8"].opt_bin/"python3"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-tunein.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.8"].opt_bin/"python3"
    system python3, "-c", "import mopidy_tunein"
  end
end
