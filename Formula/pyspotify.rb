class Pyspotify < Formula
  desc "Python wrapper for libspotify"
  homepage "https://pyspotify.readthedocs.io/"
  url "https://files.pythonhosted.org/packages/fe/1d/83d088397d95eacf6281ae748886d024aab50efdea50aedf8f294fc53aa7/pyspotify-2.1.3.tar.gz"
  sha256 "6ae31d8ccd7e1f138a80f08c766173b2ced12d196732f68aee4ae023b7a9ad2a"
  head "https://github.com/mopidy/pyspotify.git"
  revision 2

  depends_on "python@3.9"
  depends_on "libffi"
  depends_on "mopidy/mopidy/libspotify"

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2d/bf/960e5a422db3ac1a5e612cb35ca436c3fc985ed4b7ed13a1b4879006f450/cffi-1.13.2.tar.gz"
    sha256 "599a1e8ff057ac530c9ad1778293c665cb81a791421f46922d80a86473c13346"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz"
    sha256 "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3"
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
    (prefix/site_packages/"homebrew-pyspotify.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import spotify"
  end
end
