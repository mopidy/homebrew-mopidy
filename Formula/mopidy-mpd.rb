class MopidyMpd < Formula
  desc "Mopidy extension for controlling Mopidy from MPD clients"
  homepage "https://github.com/mopidy/mopidy-mpd"
  url "https://files.pythonhosted.org/packages/10/a1/af1f72d84b07fbc9353b5c4a37540b59ee5072fcc2f1791f81386046f1f9/Mopidy-MPD-3.0.0.tar.gz"
  sha256 "4c452e8ad8fbf13322b510cd48bc5bef5779d2ac8f39cd5e0ca2883248a4325f"
  head "https://github.com/mopidy/mopidy-mpd.git"
  revision 1

  depends_on "python@3.8"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.8"].opt_bin/"python3"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-mpd.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.8"].opt_bin/"python3"
    system python3, "-c", "import mopidy_mpd"
  end
end
