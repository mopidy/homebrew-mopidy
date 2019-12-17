class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/88/8b/12ca08dde0ce4542d42aa3d1e31324cdfa8e0d8f4588defb07044da2db4d/Mopidy-Spotify-4.0.0a2.tar.gz"
  sha256 "2b60be5f92d6a404eb62c3749e01ada851e89906bc076b56090e70f5ee27b196"
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
