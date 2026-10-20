cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.6"
  sha256 arm:   "a907ab201f256f72e5d763d64b740ce12558adb7ffc6ca1ed659f1e06cc86970",
         intel: "9dab0c63379825c75f46da984e0f1499c91ae5c80b7a3fcc967f012dbaa1c003"

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
