class MopidyTunein < Formula
  desc "Mopidy extension for playing music from TuneIn"
  homepage "https://github.com/kingosticks/mopidy-tunein"
  url "https://files.pythonhosted.org/packages/dc/8a/1eabe4403f411a7f372cf013809177f2211be62a8cfc613d8eb1060b3e31/Mopidy-TuneIn-1.0.2.tar.gz"
  sha256 "6c5222276882d435e5dd245cea27e66eb66ad6b03e1994a62f03458ed4846ed7"
  head "https://github.com/kingosticks/mopidy-tunein.git"

  depends_on "python@3.9"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.9"].opt_bin/"python3"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-tunein.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy_tunein"
  end
end
