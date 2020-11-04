class MopidyInternetarchive < Formula
  desc "Mopidy extension for playing music from the Internet Archive"
  homepage "https://github.com/tkem/mopidy-internetarchive"
  url "https://files.pythonhosted.org/packages/e3/4a/159fd84d3f4d4ece603ebbb3f5e0ca0192084e9b5da5fcdab7eebb87e902/Mopidy-InternetArchive-3.0.0.tar.gz"
  sha256 "bbd1fbcddfa06caaa088a3bf3533d4a7aa8bc8f4e4b11019b4664cc8426e7363"
  head "https://github.com/tkem/mopidy-internetarchive.git"
  revision 2

  depends_on "python@3.9"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/ff/e9/879bc23137b5c19f93c2133a6063874b83c8e1912ff1467a3d4331598921/cachetools-4.0.0.tar.gz"
    sha256 "9a52dd97a85f257f4e4127f15818e71a0c7899f121b34591fcc1173ea79a0198"
  end

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/0e/16/f6c423dfe3e4a0e3bc00f4f2f540f3618a918b9b4fd0ec4ef51407931592/uritools-3.0.0.tar.gz"
    sha256 "405917a31ce58a57c8ccd0e4ea290f38baf2f4823819c3688f5331f1aee4ccb0"
  end

  def install
    python3 = Formula["python@3.9"].opt_bin/"python3"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-internetarchive.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy_internetarchive"
  end
end
