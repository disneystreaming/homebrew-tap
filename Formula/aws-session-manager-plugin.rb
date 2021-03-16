class AwsSessionManagerPlugin < Formula
  desc "Official Amazon AWS session manager plugin"
  homepage "https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
  version "1.2.54.0"

  if OS.mac?
    url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/mac/sessionmanager-bundle.zip"
    sha256 "920c6842bb6edadb15e6dff7a00f99da3b98db884f3b39cf1a395032ca8e2198"

    def install
      bin.install "bin/session-manager-plugin"
      prefix.install %w[LICENSE VERSION]
    end

  # Linux Install extracts the deb file
  elsif OS.linux?
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_64bit/session-manager-plugin.deb"
        sha256 "bae835713e3247135071ffb35b3d268bbd86e0419adde64756e1b7e88352aab3"
      elsif Hardware::CPU.is_32_bit?
        url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_32bit/session-manager-plugin.deb"
        sha256 "bc504b5262fefd307a176662655b410a69c980260c5773bded108c1566635196"
      end
    elsif Hardware::CPU.arm?
      url "https://s3.amazonaws.com/session-manager-downloads/plugin/#{version}/ubuntu_arm64/session-manager-plugin.deb"
      sha256 "6072065903705bc697e25bc1bd7009386a865fdffd7bdc72fb93b2b692d3add6"
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
