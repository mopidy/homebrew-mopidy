class MopidyBeets < Formula
  desc "Mopidy extension for playing music from Beets with its web plugin"
  homepage "https://github.com/mopidy/mopidy-beets"
  url "https://files.pythonhosted.org/packages/43/76/26231228ba3eb99875d94c3eddcc519c32f62ed39acaeec5fb8df4211997/Mopidy-Beets-4.0.1.tar.gz"
  sha256 "6a3310f12da35bd737763ffbe7bab2301ad8340d74470d222817d2c39ba2a0d1"
  head "https://github.com/mopidy/mopidy-beets.git"

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
    (prefix/site_packages/"homebrew-mopidy-beets.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_beets"
  end
end
