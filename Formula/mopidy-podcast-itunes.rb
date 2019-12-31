class MopidyPodcastItunes < Formula
  desc "Mopidy extension for searching and browsing podcasts on the Apple iTunes Store"
  homepage "https://github.com/tkem/mopidy-podcast-itunes"
  url "https://files.pythonhosted.org/packages/95/95/cdd4c37233d5653ce65a3ae35e56196a8815c789a2c624c88d603bd11008/Mopidy-Podcast-iTunes-3.0.0.tar.gz"
  sha256 "11b0faf4d099336bb63afe7478ee1d387aeb2c6552a275b196c351a62e65b2e6"
  head "https://github.com/tkem/mopidy-podcast-itunes.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/mopidy-podcast"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-podcast-itunes.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_podcast_itunes"
  end
end
