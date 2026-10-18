# gb — GreaseBook CLI

Read your GreaseBook data from a terminal, or from an AI assistant such as Claude Code, with the same
permissions you have on the GreaseBook site.

## Install

**macOS (Homebrew)**

```bash
brew tap greasebook/cli https://github.com/GreaseBook/cli
brew trust greasebook/cli
brew install --cask gb
```

`brew trust` is required by Homebrew 7 for any tap outside Homebrew's own (https://docs.brew.sh/Tap-Trust).
Installed `gb` 0.1.0 as a formula? Switch with `brew uninstall gb && brew update && brew install --cask gb`.
Homebrew on Linux is not supported; use the `.tar.gz` from the release.

**Windows:** download `gb_0.1.2_windows_amd64.msi` from the
[latest release](https://github.com/GreaseBook/cli/releases/latest) and run it.

**Linux and manual installs:** every release has archives for macOS, Linux and Windows, plus `checksums.txt`.

## Sign in

```bash
gb login
```

In GreaseBook, open your name menu (top right), choose **CLI token**, copy it and paste it into `gb login`.
The token is read-only and does not expire. It ends when you press **Renew** on that screen, on `gb logout`, or
when your password changes. Your company must have the CLI turned on; ask GreaseBook support.

## Use

```bash
gb whoami
gb facilities --active --format csv
gb logout
```

Output is a table by default; use `--format json` for scripts and AI assistants, or `--format csv`. Run `gb --help` for every command.
