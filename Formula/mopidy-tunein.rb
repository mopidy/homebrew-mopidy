class MopidyTunein < Formula
  desc "Mopidy extension for playing music from TuneIn"
  homepage "https://github.com/kingosticks/mopidy-tunein"
  url "https://files.pythonhosted.org/packages/22/c4/7efb36a75643a249528f191d1a9a130d9d62e4907aa35f4f9853e1fe1dd2/Mopidy-TuneIn-1.1.0.tar.gz"
  sha256 "910a96552d239bfaee6ef3635cf9018f7ef733ac311cd0b11f27334dbd56c107"
  head "https://github.com/kingosticks/mopidy-tunein.git"

  depends_on "python@3.11"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-tunein.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_tunein"
  end
end
