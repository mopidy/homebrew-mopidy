class MopidySpotify < Formula
  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/dc/9c/abd89195770fa8a7b7835f23b41657a0eddf13b58512a916da2dfd126d92/Mopidy-Spotify-4.1.1.tar.gz"
  sha256 "e137d0675288e48563c15d50cb2722c618f1a085673f96b620e64fafdaab97af"
  head "https://github.com/mopidy/mopidy-spotify.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_spotify"
  end
end
