cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.4"
  sha256 arm:   "6931fd6fc0489ea564b52e586b9173c02bb7cb38b09402a55b23579e46577f02",
         intel: "98b5b3200aa75a450a32f40ca9b5550c7d5eb7be94b84f46962c06b3669d7128"

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
