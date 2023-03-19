class MopidyLocal < Formula
  desc "Mopidy extension for playing music from your music archive"
  homepage "https://github.com/mopidy/mopidy-local"
  url "https://files.pythonhosted.org/packages/d6/2d/e2a19a920d82355723a4bfa2eb3db45f64b2f6080c6b083cf611c35049b0/Mopidy-Local-3.2.0.tar.gz"
  sha256 "a06338b3afbb5ae8694cb4f8ccd9ffa900d8cec114b33e5e1be84d3e9646c791"
  head "https://github.com/mopidy/mopidy-local.git"

  depends_on "python@3.11"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/0e/16/f6c423dfe3e4a0e3bc00f4f2f540f3618a918b9b4fd0ec4ef51407931592/uritools-3.0.0.tar.gz"
    sha256 "405917a31ce58a57c8ccd0e4ea290f38baf2f4823819c3688f5331f1aee4ccb0"
  end

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-local.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_local"
  end
end
