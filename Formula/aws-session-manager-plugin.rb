class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.398.0"

  if OS.mac?
    url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
    sha256 "417f2c11f3273ef26541aea379c26b3db2a17093808a036b3d316540d1d75a88"

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "aae58e58fcfbba465231086766d236ce8d032ae73b9335690e1faba704af2f9a"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
        sha256 "5c65a842d5114c91ddca47a35a6b5da13b72732c625cfb99997a76e11eaf5e86"
      end
    elsif Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_arm64/session-manager-plugin.deb"
      sha256 "5c65a842d5114c91ddca47a35a6b5da13b72732c625cfb99997a76e11eaf5e86"
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
