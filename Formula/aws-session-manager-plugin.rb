class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.30.0"

  if OS.mac?
    url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
    sha256 "d9b558193370b2ecc0ddba001b6ee974b14b60d4d247851706e26a9811f15349"

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "342602b05552268966bcac2ec7698447e1202eb8e3d2943066dd9954697604ef"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
      end

      def install
        system "ar", "x", "session-manager-plugin.deb"
        system "tar", "xf", "data.tar.gz"
        bin.install "usr/local/sessionmanagerplugin/bin/session-manager-plugin"
        prefix.install_metafiles
      end
    end
  end

  depends_on "awscli"

  test do
    system bin/"session-manager-plugin"
  end
end
