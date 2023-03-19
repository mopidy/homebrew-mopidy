class MopidyMpd < Formula
  desc "Mopidy extension for controlling Mopidy from MPD clients"
  homepage "https://github.com/mopidy/mopidy-mpd"
  url "https://files.pythonhosted.org/packages/32/ee/6f70528199d1ea7d5dff3b2e21fc1ac42e762797f4ba334c77c6f5e9fd18/Mopidy-MPD-3.1.0.tar.gz"
  sha256 "d34011dad9a053c149a408c25b0ff552406513063bc9cdaab2bde30e71f81228"
  head "https://github.com/mopidy/mopidy-mpd.git"

  depends_on "python@3.11"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  def install
    python3 = Formula["python@3.11"].opt_bin/"python3.11"

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
    python3 = Formula["python@3.11"].opt_bin/"python3.11"
    system python3, "-c", "import mopidy_mpd"
  end
end
