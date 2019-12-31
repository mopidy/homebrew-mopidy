class MopidySomafm < Formula
  desc "Mopidy extension for playing music from SomaFM"
  homepage "https://github.com/AlexandrePTJ/mopidy-somafm"
  url "https://files.pythonhosted.org/packages/84/4b/8c304a08c6a346b09233b5ecd26e63e7f8d089dd6c8c5d30914fe1ab2382/Mopidy-SomaFM-2.0.0rc1.tar.gz"
  sha256 "2df682c5d4ebe9f5a2d485e8413d2923ca3e406256a18ffe9fc69048f3aea90e"
  head "https://github.com/AlexandrePTJ/mopidy-somafm.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-somafm.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_somafm"
  end
end
