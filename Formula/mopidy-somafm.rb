class MopidySomafm < Formula
  desc "Mopidy extension for playing music from SomaFM"
  homepage "https://github.com/AlexandrePTJ/mopidy-somafm"
  url "https://files.pythonhosted.org/packages/f3/07/a29f0fa2f26d9948ea449f1a415cd459b47d48adfdef176fd99553cf81ac/Mopidy-SomaFM-2.0.0.tar.gz"
  sha256 "c3d1ae99867e09041f1d6565b218a5792f8438ee6196b1ecc610691f69ce08c9"
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
