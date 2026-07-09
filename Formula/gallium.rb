class Gallium < Formula
  desc "Read-only Google Tag Manager container analysis CLI"
  homepage "https://github.com/tyssejc/gallium"
  url "https://github.com/tyssejc/gallium/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f77cea7f4912c4c2414fbf98b0eddf516e6c15e76eb8b963856921bca47ed73e"
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
