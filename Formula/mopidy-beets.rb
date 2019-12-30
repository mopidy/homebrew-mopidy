class MopidyBeets < Formula
  desc "Mopidy extension for playing music from Beets with its web plugin"
  homepage "https://github.com/mopidy/mopidy-beets"
  url "https://files.pythonhosted.org/packages/32/26/3fddf9f3e4d7f09ee09724c7cfe9e0660be2f7e5e3e79bbc6ee69ba133bf/Mopidy-Beets-4.0.0rc2.tar.gz"
  sha256 "a11e98a01ff567b4e1421d1bd20aa009fd30db066a1d92b4047268073792b35f"
  head "https://github.com/mopidy/mopidy-beets.git"

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
    (prefix/site_packages/"homebrew-mopidy-beets.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_beets"
  end
end
