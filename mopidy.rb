class Mopidy < Formula
  desc "Extensible music server written in Python"
  homepage "http://www.mopidy.com/"
  url "https://pypi.python.org/packages/4f/5d/07c06dc2cacc15edc658bd8501435f067938ede429423a2acdb9e9beb8da/Mopidy-2.0.1.tar.gz"
  sha256 "af3129d8b7e45c8a2af34f2b50592f64c00aaa0400ef6e6c742b6587ea9bdf67"
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
