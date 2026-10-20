cask "gb" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.5"
  sha256 arm:   "a5ea17c1ba6dd3a96c7958f2f54a0401bca248216bd16c32ac2e01171ab2e142",
         intel: "e73acc8604b82ab7c51781adb38f85b3737630223d2f89277a19595d160ec377"

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
