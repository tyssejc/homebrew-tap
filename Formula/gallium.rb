class Gallium < Formula
  desc "Read-only Google Tag Manager container analysis CLI"
  homepage "https://github.com/tyssejc/gallium"
  url "https://github.com/tyssejc/gallium/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "447e25f2b0f9dedd2f96d558ab5bfa633aab1bb7b0ba8c12459ae8b0cdca452b"
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
