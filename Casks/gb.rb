cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.8"
  sha256 arm:   "6fc326fcec1a54167cf5a03dacfb7d519ba1b291e3ead49da2292c63dd9a8f74",
         intel: "a32b2d1505dbdd9dbbfa898db3a2dce4e74c93a78d81f389d5e19c52bfef6be1"

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
