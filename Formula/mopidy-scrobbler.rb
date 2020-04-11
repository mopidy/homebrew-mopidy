class MopidyScrobbler < Formula
  desc "Mopidy extension for scrobbling played tracks to Last.fm"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://files.pythonhosted.org/packages/78/30/8ca1603b687a37b3773f574c5a419d7eea659d52f4018a93c46471998da1/Mopidy-Scrobbler-2.0.0.tar.gz"
  sha256 "2411e92303cd5950f5a24ef476638bffc066b43f79e7422b3727b7e120e91d69"
  head "https://github.com/mopidy/mopidy-scrobbler.git"
  revision 1

  depends_on "python@3.8"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka

  resource "pylast" do
    url "https://files.pythonhosted.org/packages/c1/3b/05414f6c406d571604a6ee19530ba0a0bd35a8c2cae158ffac0caaa74179/pylast-3.1.0.tar.gz"
    sha256 "7eb58682beccc0052c3284aba64a9a6454b5e89706f789ebeb2403dc1045606a"
  end

  def install
    python3 = Formula["python@3.8"].opt_bin/"python3"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-scrobbler.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.8"].opt_bin/"python3"
    system python3, "-c", "import mopidy_scrobbler"
  end
end
