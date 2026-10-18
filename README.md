# gb — GreaseBook CLI

Read your GreaseBook data from a terminal, or from an AI assistant such as Claude Code, with the same
permissions you have on the GreaseBook site.

## Install

**macOS and Linux (Homebrew)**

```bash
brew tap greasebook/cli https://github.com/GreaseBook/cli
brew install gb
```

**Windows:** download `gb_0.1.0_windows_amd64.msi` from the
[latest release](https://github.com/GreaseBook/cli/releases/latest) and run it.

**Manual:** every release has archives for macOS, Linux and Windows, plus `checksums.txt`.

## Sign in

```bash
gb login
```

`gb login` asks for your GreaseBook session token. It uses it once to open a separate, read-only CLI
session and does not keep it. The CLI session ends after 30 days without use, on `gb logout`, or when your
password changes.

## Use

```bash
gb whoami
gb facilities --active --format csv
gb logout
```

Output is JSON by default, or CSV with `--format csv`. Run `gb --help` for every command.
