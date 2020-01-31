class MopidyLocal < Formula
  desc "Mopidy extension for playing music from your music archive"
  homepage "https://github.com/mopidy/mopidy-local"
  url "https://files.pythonhosted.org/packages/03/a9/650dfbd029d38ff38b8bd1c8516ae91272a800f60d1289746cd070ba7b01/Mopidy-Local-3.1.1.tar.gz"
  sha256 "3205082a4543ecf38378b34e30344dc892bdb18ed73d93eab5f47a4ac28fa08e"
  head "https://github.com/mopidy/mopidy-local.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/0e/16/f6c423dfe3e4a0e3bc00f4f2f540f3618a918b9b4fd0ec4ef51407931592/uritools-3.0.0.tar.gz"
    sha256 "405917a31ce58a57c8ccd0e4ea290f38baf2f4823819c3688f5331f1aee4ccb0"
  end

  def install
    resources.each do |r|
      r.stage do
        system "python3", *Language::Python.setup_install_args(libexec)
      end
    end

    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-local.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_local"
  end
end
