class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://files.pythonhosted.org/packages/17/95/3e5ed70a97096ff03f398214a680bdddba3c60329799534de36834600602/Mopidy-SoundCloud-2.1.0.tar.gz"
  sha256 "8859cae010429531ce780d39a60d74e345ac24ef409d3fcaeaf83079842a3ca2"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-soundcloud.pth").write pth_contents
  end

  test do
    system "python", "-c", "import mopidy_soundcloud"
  end
end
