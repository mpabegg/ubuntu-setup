# ubuntu-setup

🛠️ Minimal setup script for configuring a fresh Ubuntu install.

This repository will grow step by step. The current version **only updates the system**.

---

## ⚡ Quick Install

> ⚠️ Review the script before running.

```bash
wget -qO- https://raw.githubusercontent.com/mpabegg/ubuntu-setup/main/bootstrap.sh | bash

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
| `build-essential`         | Installs GCC, `make`, and libraries needed to compile most software |
| `software-properties-common` | Adds support for `add-apt-repository` and managing PPAs |
