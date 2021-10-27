# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class SsmHelpers < Formula
  desc "Help manage systems with AWS Systems Manager with management helpers."
  homepage "https://github.com/disneystreaming/ssm-helpers"
  version "1.1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/disneystreaming/ssm-helpers/releases/download/v1.1.1/ssm-helpers_1.1.1_Darwin_x86_64.tar.gz"
      sha256 "4bad096d8820ea7acc1076dda34fee82022abf52f8f04e1e1ffcabb410469001"

      def install
        bin.install "ssm"
        bin.install_symlink  bin/"ssm" => "ssm-helpers"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/disneystreaming/ssm-helpers/releases/download/v1.1.1/ssm-helpers_1.1.1_Linux_x86_64.tar.gz"
      sha256 "40424036a02b09db974e0e3137a6eda2dffb6823a08a1a42c7b50a06dcd79bb0"

      def install
        bin.install "ssm"
        bin.install_symlink  bin/"ssm" => "ssm-helpers"
      end
    end
  end

  depends_on "awscli"
  depends_on "disneystreaming/tap/aws-session-manager-plugin"
end
