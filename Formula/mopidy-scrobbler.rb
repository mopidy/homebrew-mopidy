class MopidyScrobbler < Formula
  desc "Mopidy extension for scrobbling played tracks to Last.fm"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://files.pythonhosted.org/packages/4b/2b/f5e71a37ca6698e4f287384482601b869d48fefeed8823b5db87a358bcfc/Mopidy-Scrobbler-2.0.1.tar.gz"
  sha256 "001920edc5433678091cb74c56e39c57ffcdb280396447b07d6fbe4eba7a7d87"
  head "https://github.com/mopidy/mopidy-scrobbler.git"

  depends_on "python@3.9"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka

  resource "pylast" do
    url "https://files.pythonhosted.org/packages/c1/3b/05414f6c406d571604a6ee19530ba0a0bd35a8c2cae158ffac0caaa74179/pylast-3.1.0.tar.gz"
    sha256 "7eb58682beccc0052c3284aba64a9a6454b5e89706f789ebeb2403dc1045606a"
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
    (prefix/site_packages/"homebrew-mopidy-scrobbler.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.9"].opt_bin/"python3"
    system python3, "-c", "import mopidy_scrobbler"
  end
end
