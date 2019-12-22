class MopidySoundcloud < Formula
  desc "Mopidy extension for playing music from SoundCloud"
  homepage "https://github.com/mopidy/mopidy-soundcloud"
  url "https://files.pythonhosted.org/packages/83/55/58ddb9770ed9bd0fcf765a486f15261d78265562bf208f9dc3f5dab55166/Mopidy-SoundCloud-3.0.0.tar.gz"
  sha256 "9c1732d6f06a71f8573b035c5b920dfa3448e7681dba882394e664fdf5d80197"
  head "https://github.com/mopidy/mopidy-soundcloud.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-soundcloud.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_soundcloud"
  end
end
