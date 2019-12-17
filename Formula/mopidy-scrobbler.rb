class MopidyScrobbler < Formula
  desc "Mopidy extension for scrobbling played tracks to Last.fm"
  homepage "https://github.com/mopidy/mopidy-scrobbler"
  url "https://files.pythonhosted.org/packages/a8/73/32f00830ca4762bd67c89044c5124d30f38d919cd6214c5d5abbeea4d3ef/Mopidy-Scrobbler-2.0.0rc1.tar.gz"
  sha256 "2735bf752ae32ae322b51aa5cf4c7b5210cd17d2cd2d89a7dbd6bfb6e2b4e8b1"
  head "https://github.com/mopidy/mopidy-scrobbler.git"

  depends_on "python"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka

  resource "pylast" do
    url "https://files.pythonhosted.org/packages/c1/3b/05414f6c406d571604a6ee19530ba0a0bd35a8c2cae158ffac0caaa74179/pylast-3.1.0.tar.gz"
    sha256 "7eb58682beccc0052c3284aba64a9a6454b5e89706f789ebeb2403dc1045606a"
  end

  def install
    resources.each do |r|
      r.stage do
        system "python3", *Language::Python.setup_install_args(libexec)
      end
    end

    system "python3", *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version "python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-scrobbler.pth").write pth_contents
  end

  test do
    system "python3", "-c", "import mopidy_scrobbler"
  end
end
