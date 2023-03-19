class MopidySomafm < Formula
  desc "Mopidy extension for playing music from SomaFM"
  homepage "https://github.com/AlexandrePTJ/mopidy-somafm"
  url "https://files.pythonhosted.org/packages/69/96/c3209d56b31def06abe642b9360c3143d9f94721b834790aa2f97b33ced3/Mopidy-SomaFM-2.0.1.tar.gz"
  sha256 "2952e00d8a22e05bbfc2e15d4719b9b18bca2b9880ff72590c122c6690e894bf"
  head "https://github.com/AlexandrePTJ/mopidy-somafm.git"
  revision 2

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
    (prefix/site_packages/"homebrew-mopidy-somafm.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_somafm"
  end
end
