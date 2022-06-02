class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.245.0"

  if OS.mac?
    url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
    sha256 "884fe1d003a9001cfe3f5243a5d42153d6ad03645c78897a8f2545d89dc77e5f"

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "f1c03d2aaad9f89f73fc70f1c1cdef0e2877a03b86cca3c8b5c97992c6344449"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
        sha256 "bb20e8d65fa241b0b4045135c68966c5079a47d0549c73b4327d9c066edb6712"
      end
    elsif Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_arm64/session-manager-plugin.deb"
      sha256 "79101aade5f61dc8437aa0b31804a443b36aea47c5273c9f06a8f70ac2937b38"
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
