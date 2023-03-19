class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://files.pythonhosted.org/packages/d9/cf/1f59310b445e22848332a7008c43e4ed2771254e0cc57ebe9dcb3185945d/Mopidy-SoundCloud-3.0.1.tar.gz"
  sha256 "dd50f42c1519ec684c803a6406f3f689e1079c965dc8c8bcd132844f44ac65d7"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

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
    (prefix/site_packages/"homebrew-mopidy-soundcloud.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_soundcloud"
  end
end
