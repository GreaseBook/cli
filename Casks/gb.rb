cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.4"
  sha256 arm:   "2428e6575370d9ed2cf0a9772ee5ecc418f59ff01e964747c3cde1a2dc243d95",
         intel: "92a234f59afb1ba209aa7f3c30281cee67b278f14f2a86a1a2c1dd75fec4a004"

  url "https://github.com/GreaseBook/cli/releases/download/v#{version}/gb_#{version}_darwin_#{arch}.tar.gz"
  name "GreaseBook CLI"
  desc "Read your GreaseBook data from the terminal"
  homepage "https://cli.greasebook.com"

  binary "gb"
  bash_completion "completions/gb.bash"
  zsh_completion "completions/_gb"
  fish_completion "completions/gb.fish"

  # Temporary until the binary is signed and notarized: without it Gatekeeper blocks the first run. Remove it then.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/gb"]
  end
end
