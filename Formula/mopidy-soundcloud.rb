class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://files.pythonhosted.org/packages/51/9b/9788ca4a2165ef279f18a1945691352be3649589a34066a9805dab39ac53/Mopidy-SoundCloud-3.0.0rc1.tar.gz"
  sha256 "dfba154683f71ee1dce18fb7d3ace5a0cb3dea2121328b556fe80432b1283d9e"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

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
    (prefix/site_packages/"homebrew-mopidy-soundcloud.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_soundcloud"
  end
end
