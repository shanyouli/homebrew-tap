class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  version "1.13.13"
  url "https://github.com/tw93/Mole/archive/refs/tags/V#{version}.tar.gz"
  sha256 "9e1b1a5eb0751430abe69f2f94c4df5f7ce88fba1eadf661bfa9cff7921794d5"
  license "MIT"

  # Requires macOS-specific features
  depends_on :macos

  livecheck do
    url "https://github.com/tw93/Mole"
    strategy :github_latest
    # regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  def install
    # Install all library files to libexec
    libexec.install "bin", "lib"

    # Install main executable
    # Modify SCRIPT_DIR to point to libexec
    inreplace "mole",
              'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
              "SCRIPT_DIR=\"#{libexec}\""

    bin.install "mole"

    # Install mo alias (short command)
    inreplace "mo",
              'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
              "SCRIPT_DIR=\"#{bin}\""

    bin.install "mo"
  end

  def caveats
    <<~EOS
      Mole is a macOS cleanup tool that requires administrative privileges for some operations.

      You can use either 'mole' or 'mo' command:
        mo                # Interactive menu
        mo clean          # System cleanup
        mo uninstall      # Remove applications
        mo analyze        # Disk space explorer

      To update Mole, use: mo update
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mole --version")
    assert_match "Mole", shell_output("#{bin}/mo --help")
  end
end
