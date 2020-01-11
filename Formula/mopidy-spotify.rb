class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/f2/d2/0ce7f0f948fa91175bc34b23be9c4c70323d121acb4cc089bd72fc2769df/Mopidy-Spotify-4.0.1.tar.gz"
  sha256 "ab437903b9fee931864d62ba03af5d2517dd844f4c8476e1ba26b280daf40508"
  head "https://github.com/mopidy/mopidy-spotify.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"
  depends_on "mopidy/mopidy/pyspotify"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_spotify"
  end
end
