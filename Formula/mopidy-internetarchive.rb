class MopidyInternetarchive < Formula
  desc "Mopidy extension for playing music from the Internet Archive"
  homepage "https://github.com/tkem/mopidy-internetarchive"
  url "https://files.pythonhosted.org/packages/21/9c/98fd4ec4372605187fca0fad02b98e341ec97bb2f63385cc9a379850944c/Mopidy-InternetArchive-3.0.1.tar.gz"
  sha256 "800efa2ccf0c6e99e1eec8599d6f7fc31f153c6c5a2028083c38b4a90884d10a"
  head "https://github.com/tkem/mopidy-internetarchive.git"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies assumed bundled by mopidy:
  # - pykka
  # - requests

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/4d/91/5837e9f9e77342bb4f3ffac19ba216eef2cd9b77d67456af420e7bafe51d/cachetools-5.3.0.tar.gz"
    sha256 "13dfddc7b8df938c21a940dfa6557ce6e94a2f1cdfa58eb90c805721d58f2c14"
  end

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
    (prefix/site_packages/"homebrew-mopidy-internetarchive.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_internetarchive"
  end
end
