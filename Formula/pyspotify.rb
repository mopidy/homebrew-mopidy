class Pyspotify < Formula
  desc "Python binding for libspotify"
  homepage "https://pyspotify.mopidy.com/"
  url "https://files.pythonhosted.org/packages/source/p/pyspotify/pyspotify-2.0.5.tar.gz"
  sha256 "fbd41c58d62232b0cabb7a9e38d45f36ac221699c006899bdb6be74c04602678"
  head "https://github.com/mopidy/pyspotify.git", :branch => "v2.x/develop"

  depends_on "python@2" => :recommended
  depends_on "python" => :recommended
  depends_on "libffi"
  depends_on "mopidy/mopidy/libspotify"

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"
    sha256 "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"
    sha256 "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"
  end

  def install
    Language::Python.each_python(build) do |python, version|
      %w[pycparser cffi].each do |r|
        resource(r).stage do
          system python, *Language::Python.setup_install_args(libexec)
        end
      end

      system python, *Language::Python.setup_install_args(libexec)

      site_packages = "lib/python#{version}/site-packages"
      pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
      (prefix/site_packages/"homebrew-pyspotify.pth").write pth_contents
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import spotify"
    end
  end
end
