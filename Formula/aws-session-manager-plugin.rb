class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.331.0"

  if OS.mac?
    url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
    sha256 "eeabb8ddfc014ff52191b8b82613535a7cc2f17cfbb259fdb47dcb645b76263f"

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "c569d8f3d76c9641a145387d96544592e52a6088c740db7e4cb9e43d0af7bb54"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
        sha256 "784a3f023be177ec90de50abe13bb42968562fae9dfd93b9994ac4e51307f685"
      end
    elsif Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_arm64/session-manager-plugin.deb"
      sha256 "404ebe1232e8c9d4cfb8b8ad1ba7c02d702dbc891fca816e5a28fc6761d3ebe4"
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
