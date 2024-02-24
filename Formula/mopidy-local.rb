class MopidyLocal < Formula
  desc "Mopidy extension for playing music from your music archive"
  homepage "https://github.com/mopidy/mopidy-local"
  url "https://files.pythonhosted.org/packages/06/c3/5426543db3a53285ab1e45ad5e3ca261a41db20838ce68038c4ee0f7d41d/Mopidy-Local-3.2.1.tar.gz"
  sha256 "29165157134fe869228da675e4d0083888368a29dc7dd3203fe1a27d7b4d83a3"
  head "https://github.com/mopidy/mopidy-local.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "uritools" do
    url "https://files.pythonhosted.org/packages/4d/8b/f49813253c29c49a3767256cbe94a2450d3377953fedcd8e62be200c0ba0/uritools-4.0.1.tar.gz"
    sha256 "efc5c3a6de05404850685a8d3f34da8476b56aa3516fbf8eff5c8704c7a2826f"
  end

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

    resources.each do |r|
      r.stage do
        system python3, *Language::Python.setup_install_args(libexec)
      end
    end

    system python3, *Language::Python.setup_install_args(libexec)

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-local.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_local"
  end
end
