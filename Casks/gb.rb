cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.9"
  sha256 arm:   "5d9106821cb75827ce40b17fba884359a253a0806b8343b056e342ec8748c547",
         intel: "e031e93a7175368f5dc0651eee246ea74ae3f114a3baf62196642b1e16b54a4c"

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
