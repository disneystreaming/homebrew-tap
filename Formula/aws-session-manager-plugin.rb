class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.463.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac_arm64/sessionmanager-bundle.zip"
      sha256 "7daa4582b05ed2c5d8d15fd1a941b88613b06f66d1266226110649859a90809f"
    else
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
      sha256 "495a21233fa3fe2c9b929fd95283a347f272995073241b5191c7d894368fe96b"
    end

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "cc58fc31e2239230336b243fa97bd63a7202068dd7ce8470eaf654c1928c10a8"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
        sha256 "d23e876a7837e23e3f8b8ce64bfcaa136520109ff99adda7e1d902c2436bc719"
      end
    elsif Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_arm64/session-manager-plugin.deb"
      sha256 "cec94af11c44b94a43ce4ae1c2269bc257a4ed293238dd67b92c5f51827edcce"
    end

      def install
        system "ar", "x", "session-manager-plugin.deb"
        system "tar", "xf", "data.tar.gz"
        bin.install "usr/local/sessionmanagerplugin/bin/session-manager-plugin"
        prefix.install_metafiles
      end
  end

  depends_on "awscli"

  test do
    system bin/"session-manager-plugin"
  end
end
