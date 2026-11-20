class Gallium < Formula
  desc "Google Tag Manager container analysis and workspace-edit CLI"
  homepage "https://github.com/tyssejc/gallium"
  url "https://github.com/tyssejc/gallium/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "af3c6f9ba6635049569c054384b6280428b58f5c5c7db3caf4f600d6ccf75c0d"
  license "MIT"
  head "https://github.com/tyssejc/gallium.git", branch: "main"

  # Bun is in homebrew-core. If `brew install` fails to resolve this at build
  # time, fall back to the tap form: "oven-sh/bun/bun".
  depends_on "bun" => :build

  def install
    system "bun", "install", "--frozen-lockfile"
    system "bun", "build", "./bin/gallium.ts", "--compile", "--outfile", "gallium"
    bin.install "gallium"
  end

  def caveats
    <<~EOS
      To enable the gallium skill in Claude Code, run:
        gallium skill install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gallium --version")
    system bin/"gallium", "--help"
  end
end
