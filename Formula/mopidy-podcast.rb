class MopidyPodcast < Formula
  desc "Mopidy extension for browsing and playing podcasts"
  homepage "https://github.com/tkem/mopidy-podcast"
  url "https://files.pythonhosted.org/packages/2a/88/c40f0e727d20849ae67f247a4aa0dd5bcac7f76e27f613cbaf187f5c68bc/Mopidy-Podcast-3.0.0.tar.gz"
  sha256 "b9e360b817aa53d700909860f87ba58500ae76fe6c9e7a2e72ecb6ed87284bfc"
  head "https://github.com/tkem/mopidy-podcast.git"
  revision 2

  depends_on "python@3.9"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/ff/e9/879bc23137b5c19f93c2133a6063874b83c8e1912ff1467a3d4331598921/cachetools-4.0.0.tar.gz"
    sha256 "9a52dd97a85f257f4e4127f15818e71a0c7899f121b34591fcc1173ea79a0198"
  end

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/0e/16/f6c423dfe3e4a0e3bc00f4f2f540f3618a918b9b4fd0ec4ef51407931592/uritools-3.0.0.tar.gz"
    sha256 "405917a31ce58a57c8ccd0e4ea290f38baf2f4823819c3688f5331f1aee4ccb0"
  end

  def install
    python3 = Formula["python@3.9"].opt_bin/"python3"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-podcast.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy_podcast"
  end
end
