class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "http://www.mopidy.com/"
  url "https://pypi.python.org/packages/source/M/Mopidy/Mopidy-2.0.0.tar.gz"
  sha256 "14a04c249f83d42f2012b580f3a05853f56320f1bb68ac91c4068b64c81a9265"
  head "https://github.com/mopidy/mopidy.git"

  depends_on :python
  depends_on "gst-plugins-base" => [
    "with-libogg",
    "with-libvorbis",
    "with-theora"
  ]
  depends_on "gst-plugins-good" => [
    "with-flac",
    "with-jpeg",
    "with-libshout",
    "with-libsoup",
    "with-speex",
    "with-taglib"
  ]
  depends_on "gst-plugins-bad" => [
    "with-faad2",
    "with-libmms",
    "with-opus"
  ]
  depends_on "gst-plugins-ugly" => [
    "with-flac",
    "with-lame",
    "with-libmms",
    "with-libvorbis",
    "with-mad",
    "with-libshout",
    "with-theora",
    "with-two-lame"
  ]
  depends_on "gst-python"
  depends_on "mopidy/mopidy/python-pykka"
  depends_on "mopidy/mopidy/python-tornado"
  depends_on "mopidy/mopidy/python-requests"

  def install
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python", "-c", "import mopidy"
  end

  plist_options :manual => "mopidy"

  def plist_name
    "homebrew.mopidy." + name
  end

  def plist; <<-EOS.undent
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
end
