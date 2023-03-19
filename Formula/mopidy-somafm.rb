class MopidySomafm < Formula
  desc "Mopidy extension for playing music from SomaFM"
  homepage "https://github.com/AlexandrePTJ/mopidy-somafm"
  url "https://files.pythonhosted.org/packages/0e/6a/4cc6c5d1c813ec98343f24be7df3318acf118d2920ceeea6b6d31da1f1f0/Mopidy-SomaFM-2.0.2.tar.gz"
  sha256 "0c2d1e9b192859f8c61e28760bc9c8341141c9fe76d577fedcab38251c4d3cb3"
  head "https://github.com/AlexandrePTJ/mopidy-somafm.git"

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
