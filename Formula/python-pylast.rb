class PythonPylast < Formula
  desc "A Python interface to Last.fm and Libre.fm"
  homepage "https://github.com/pylast/pylast"
  url "https://files.pythonhosted.org/packages/64/ab/973b67a9dfd27d6356c5e275d7d369b35879fe88bda6e1b20453b4d08511/pylast-1.8.0.tar.gz"
  sha256 "85f8dd96aef0ccba5f80379c3d7bc1fabd72f59aebab040daf40a8b72268f9bd"
  head "https://github.com/pylast/pylast.git"

  depends_on "python@2" => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => :optional

  def install
    Language::Python.each_python(build) do |python, _version|
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import pylast"
    end
  end
end
