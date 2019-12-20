class MopidyMpd < Formula
  desc "Mopidy extension for controlling Mopidy from MPD clients"
  homepage "https://github.com/mopidy/mopidy-mpd"
  url "https://files.pythonhosted.org/packages/26/26/ed399e21096d23b1a3e28afb9b7e934235c6cc86e7c92e14f1cead6aec7a/Mopidy-MPD-3.0.0rc1.tar.gz"
  sha256 "49acf3284c61b7f9c7cb75ae437b9571c154cfb9af594d635915e0ed7b2f2480"
  head "https://github.com/mopidy/mopidy-mpd.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

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
    (prefix/site_packages/"homebrew-mopidy-mpd.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_mpd"
  end
end
