# ubuntu-setup

🛠️ Minimal setup script for configuring a fresh Ubuntu install with essential tools for development, system utilities, and password management.

> ⚠️ I'm vibe coding the whole thing to know how it feels.

---

## ⚡ Quick Install

> ✅ This will clone the repo into `~/.dotfiles` and run the install script automatically.

```bash
wget -qO- https://raw.githubusercontent.com/mpabegg/ubuntu-setup/main/bootstrap.sh | bash
```

---

## 📦 What It Does (So Far)

1. **Updates your system**

   Runs:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Installs core CLI tools**

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

3. **Installs system utilities**

| Tool         | Description |
|--------------|-------------|
| `htop`       | Interactive system monitor and process viewer |
| `neofetch`   | Displays system info in a visually appealing way |
| `p7zip-full` | Adds support for `.7z` archives and advanced compression formats |
| `tree`       | Shows directory structures as a tree (recursive `ls`) |
| `lsb-release`| Prints Ubuntu version info; useful in scripts |

4. **Installs developer tools and dotfiles**

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
| `zsh/`, `tmux/` | Dotfile configs linked into your home directory via `stow` |

5. **Installs 1Password**

| Tool         | Description |
|--------------|-------------|
| `1password`  | Secure desktop password manager installed from the official APT repository |

6. **Sets Zsh as the default shell**

Automatically runs:

```bash
chsh -s $(which zsh)
```

---

## 🔧 Manual Steps After Install

Some things need a quick follow-up after install:

1. **Restart your session**  
   To apply the default shell change (`zsh`), log out and back in.

2. **Install the 1Password Firefox extension**  
   You’ll need to do this manually:  
   [🔗 Install from Mozilla Add-ons](https://addons.mozilla.org/firefox/addon/1password-x-password-manager/)

   The extension will pair automatically with the desktop app once you're logged in.

---

## 📁 Structure

```
ubuntu-setup/
├── bootstrap.sh        # Thin entry point — clones the repo into ~/.dotfiles
├── install.sh          # Full setup logic
├── zsh/                # zsh config (.zshrc)
├── tmux/               # tmux config (.tmux.conf)
├── README.md
```

---

## 📜 License

MIT – use freely, customize wildly, vibe accordingly.
