# termux-client

Android Termux client wrappers to drive the dev VM.

## Architecture / topology

SwiftKey (typing + Google voice dictation)
  -> Termux (Android)
  -> WireGuard (VPN)
  -> SSH (keys only) to dev-vm (Ubuntu on QNAP)
  -> newproj (server tool) creates GitHub repos from template
  -> tmux session per project on dev-vm

Template:
- cdelalama/LLM-DocKit

Server tool:
- /usr/local/bin/newproj (installed from cdelalama/dev-tools)

Client tool:
- np (installed from this repo)

## Install (Android Termux)

This repo is public, so clone via HTTPS:

  pkg install -y git openssh
  cd ~
  rm -rf termux-client
  git clone https://github.com/cdelalama/termux-client.git
  cd termux-client
  chmod +x install.sh
  ./install.sh

Config:
  ~/.config/termux-client/config

## Bootstrap on a new phone (fast)

1) Install Termux (F-Droid) + WireGuard.
2) Restore or generate an SSH key in Termux.
3) Ensure the Termux public key is present on dev-vm: ~/.ssh/authorized_keys
4) Install termux-client and run `np`.

## Usage

Run:
  np

Prompt:
  Repo name:

Speak or type:
  android-005

Result:
- Creates `cdelalama/<repo>` from template `cdelalama/LLM-DocKit` if missing
- Clones into `~/src/<repo>` on dev-vm if missing
- Attaches/creates tmux session `<repo>` on dev-vm

## Troubleshooting

- Permission denied (publickey):
  Add your Termux public key to dev-vm authorized_keys.

- newproj: command not found:
  Ensure /usr/local/bin/newproj is installed on dev-vm (run dev-tools install.sh).

- SSH asks for passphrase every time:
  Use ssh-agent/keychain on the VM, or switch VM GitHub auth key to no-passphrase.
