cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.9"
  sha256 arm:   "900c411af0cdb42b2c927c6af9b43840e8baa76cd0f734c7a0c51b2049b39339",
         intel: "9d2ad1db509d760623ab5e36d5a7ecf4f5fef5837b0e283da022440b8f3f712e"

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
