# ubuntu-setup

🛠️ Minimal setup script for configuring a fresh Ubuntu install.

This repository will grow step by step. The current version updates the system and installs essential CLI, system, and developer tools.

---

## ⚡ Quick Install

> ⚠️ Review the script before running.

```bash
wget -qO- https://raw.githubusercontent.com/mpabegg/ubuntu-setup/main/bootstrap.sh | bash
```

---

## 📦 What It Does (So Far)

1. Updates your system (`apt update && apt upgrade`)
2. Installs core CLI tools:

| Tool                        | Description |
|-----------------------------|-------------|
| `git`                      | Version control system used to manage source code |
| `wget`                     | Command-line tool to download files over HTTP/S or FTP |
| `curl`                     | Data transfer tool that supports many protocols (used in APIs, scripts) |
| `unzip`                    | Extracts `.zip` archive files |
| `gnupg`                    | Enables encryption, signing, and managing keys (used for secure package installs) |
| `ca-certificates`          | Provides trusted SSL certificates for secure HTTPS connections |
| `build-essential`          | Installs GCC, `make`, and libraries needed to compile most software |
| `software-properties-common` | Adds support for `add-apt-repository` and managing PPAs |

3. Installs system utilities:

| Tool         | Description |
|--------------|-------------|
| `htop`       | Interactive system monitor and process viewer |
| `neofetch`   | Displays system info in a visually appealing way |
| `p7zip-full` | Adds support for `.7z` archives and advanced compression formats |
| `tree`       | Shows directory structures as a tree (recursive `ls`) |
| `lsb-release`| Prints Ubuntu version info; useful in scripts |

4. Installs developer tools:

| Tool       | Description |
|------------|-------------|
| `zsh`      | Shell with advanced features and scripting |
| `tmux`     | Terminal multiplexer (splits, sessions) |
| `jq`       | Command-line JSON processor |
| `fzf`      | Fuzzy finder for terminal |
| `ripgrep`  | Fast search in files (better `grep`) |
| `bat`      | Syntax-highlighted `cat` replacement |
| `fd-find`  | User-friendly `find` alternative |
| `stow`     | Symlink manager for dotfiles |

If `zsh/` and `tmux/` folders are present in this repo, they will be symlinked to your home directory using `stow`.

---

## 📁 Structure

```
ubuntu-setup/
├── bootstrap.sh        # Main install script
├── zsh/                # (Optional) Zsh config
├── tmux/               # (Optional) Tmux config
├── README.md
```

---

## 📜 License

MIT – use freely, customize wildly.
