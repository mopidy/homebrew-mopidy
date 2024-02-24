class MopidyPodcastItunes < Formula
  desc "Mopidy extension for searching and browsing podcasts on the Apple iTunes Store"
  homepage "https://github.com/tkem/mopidy-podcast-itunes"
  url "https://files.pythonhosted.org/packages/da/37/c056afd9471c0d32ee116ed1f0977c6bc45a1bee2bd5b47e339f198118be/Mopidy-Podcast-iTunes-3.0.1.tar.gz"
  sha256 "b31a30447506894afb74aa0d2ace21b4525c704681aafcafcc8366ad921921db"
  head "https://github.com/tkem/mopidy-podcast-itunes.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/mopidy-podcast"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-podcast-itunes.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_podcast_itunes"
  end
end
