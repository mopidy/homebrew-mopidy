class MopidyMpd < Formula
  desc "Mopidy extension for controlling Mopidy from MPD clients"
  homepage "https://github.com/mopidy/mopidy-mpd"
  url "https://files.pythonhosted.org/packages/8a/45/2ae38c8e83c7e7fd49bda4ce2ee3cd7b2454837ab763a5be192ac657bf98/Mopidy-MPD-3.3.0.tar.gz"
  sha256 "09e2cc46a8fd73006f42b3b1ed71d557c3230e3c0ea2c38d565b0dda8faf4d53"
  head "https://github.com/mopidy/mopidy-mpd.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

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
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_mpd"
  end
end
