cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.10"
  sha256 arm:   "348b985f25eb88be7f597ea1389c0b18300aab1434ed725723f7153d43468d1d",
         intel: "52065ad181657aebc6926893e9f540d6ff1d6fcd2ddfc8639790e597681be488"

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
