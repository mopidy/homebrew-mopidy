class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://files.pythonhosted.org/packages/84/59/6e556a8c0c5203228a4dad056b2cfd7b2a2a4f737fa740ed436a4b5772ee/Mopidy-SoundCloud-3.0.2.tar.gz"
  sha256 "783ac1459750c9d157bd9d097e486199a16838d6eb1268dd8a642ae37a15f3e2"
  head "https://github.com/mopidy/mopidy-soundcloud.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-soundcloud.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_soundcloud"
  end
end
