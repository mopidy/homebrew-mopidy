class MopidyBeets < Formula
  desc "Mopidy extension for playing music from Beets with its web plugin"
  homepage "https://github.com/mopidy/mopidy-beets"
  url "https://files.pythonhosted.org/packages/0e/59/72ac45e8a6b37a81d89df24052275c6a313bdcdde23eb7b6ce130433854d/Mopidy-Beets-4.0.0.tar.gz"
  sha256 "c7455617e3f96c893181aec41b54d4b5a54daf1514ea6d2313abb69bfb78e186"
  head "https://github.com/mopidy/mopidy-beets.git"
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
    (prefix/site_packages/"homebrew-mopidy-beets.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.8"].opt_bin/"python3"
    system python3, "-c", "import mopidy_beets"
  end
end
