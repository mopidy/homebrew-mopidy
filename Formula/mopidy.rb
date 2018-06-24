class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "https://www.mopidy.com/"
  url "https://files.pythonhosted.org/packages/60/76/427ad1fbe879034e34cf9898310ba5a9cc42cd36b08898059be06066fa38/Mopidy-2.1.0.tar.gz"
  sha256 "297369a34ebd584b2fe25a7184f68fe876a149256549b03b503a55ede3f13f6a"
  head "https://github.com/mopidy/mopidy.git"
  revision 1

  depends_on "python@2" if MacOS.version <= :snow_leopard
  depends_on "gst-plugins-base" => [
    "with-libogg",
    "with-libvorbis",
    "with-opus",
    "with-theora",
  ]
  depends_on "gst-plugins-good" => [
    "with-flac",
    "with-libshout",
    "with-speex",
    "with-taglib",
  ]
  depends_on "gst-plugins-bad" => [
    "with-faad2",
    "with-libmms",
    "with-opus",
  ]
  depends_on "gst-plugins-ugly" => [
    "with-flac",
    "with-lame",
    "with-libmms",
    "with-libvorbis",
    "with-mad",
    "with-libshout",
    "with-theora",
    "with-two-lame",
  ]
  depends_on "py2cairo"
  depends_on "gst-python" => [
    "without-python",
    "with-python@2",
  ]

  resource "backports_abc" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
    sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
  end

  resource "certifi" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/4d/9c/46e950a6f4d6b4be571ddcae21e7bc846fcbb88f1de3eff0f6dd0a6be55d/certifi-2018.4.16.tar.gz"
    sha256 "13e698f54293db9f89122b0581843a782ad0934a4fe0172d2a980ba77fc61bb7"
  end

  resource "chardet" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "futures" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/1f/9e/7b2ff7e965fc654592269f2906ade1c7d705f1bf25b7d469fa153f7d19eb/futures-3.2.0.tar.gz"
    sha256 "9ec02aa7d674acb8618afb127e27fde7fc68994c0437ad759fa094a574adb265"
  end

  resource "idna" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"
    sha256 "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"
  end

  resource "Pykka" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/70/f7/bb8fc78fc52a50f66dda4260f8726c62267f568066c71e2264b883b70755/Pykka-1.2.1.tar.gz"
    sha256 "e847ffeadee49b563426ab803e8eee67264d773e38ca14763fdcda56411e3c11"
  end

  resource "requests" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/b0/e1/eab4fc3752e3d240468a8c0b284607899d2fbfb236a56b7377a329aa8d09/requests-2.18.4.tar.gz"
    sha256 "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"
  end

  resource "singledispatch" do
    # Required by tornado
    url "https://files.pythonhosted.org/packages/d9/e9/513ad8dc17210db12cb14f2d4d190d618fb87dd38814203ea71c87ba5b68/singledispatch-3.4.0.3.tar.gz"
    sha256 "5b06af87df13818d14f08a028e42f566640aef80805c3b50c5056b086e3c2b9c"
  end

  resource "six" do
    # Required by singledispatch, which is required by tornado
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "tornado" do
    # Required by Mopidy
    url "https://files.pythonhosted.org/packages/e3/7b/e29ab3d51c8df66922fea216e2bddfcb6430fb29620e5165b16a216e0d3c/tornado-4.5.3.tar.gz"
    sha256 "6d14e47eab0e15799cf3cdcc86b0b98279da68522caace2bd7ce644287685f0a"
  end

  resource "urllib3" do
    # Required by requests
    url "https://files.pythonhosted.org/packages/ee/11/7c59620aceedcc1ef65e156cc5ce5a24ef87be4107c2b74458464e437a5d/urllib3-1.22.tar.gz"
    sha256 "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"
  end

  def install
    resources.each do |r|
      r.stage do
        system "python", *Language::Python.setup_install_args(libexec)
      end
    end

    system "python", *Language::Python.setup_install_args(libexec)

    site_packages = "lib/python2.7/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy.pth").write pth_contents

    bin.install Dir[libexec/"bin/*"]
  end

  plist_options :manual => "mopidy"
  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/mopidy</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
    </dict>
    </plist>
    EOS
  end

  test do
    system "python", "-c", "import mopidy"
  end

  def plist_name
    "homebrew.mopidy." + name
  end
end
