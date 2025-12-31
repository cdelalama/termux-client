# termux-client

Android Termux client wrappers to drive the dev VM.

## Architecture / topology

SwiftKey (typing + Google voice dictation)
  -> Termux (Android)
  -> WireGuard (VPN)
  -> SSH (keys only) to dev-vm (Ubuntu on QNAP)
  -> newproj (server tool) creates GitHub repos from template
  -> tmux session per project on dev-vm
  -> code-server (VS Code in browser) via SSH tunnel

Template:
- cdelalama/LLM-DocKit

Server tool:
- /usr/local/bin/newproj (installed from cdelalama/dev-tools)

Client tools:
- np (create new project: newproj --agents)
- op (pick existing project via fzf, opens VS Code web + tmux agents)
- vscode-web (SSH tunnel + open code-server in mobile browser; optional folder arg)
- bootstrap-phone (new phone setup helper)

Notes:
- `doctor-phone` checks GitHub SSH by matching output because `ssh -T git@github.com` may exit non-zero even when authentication succeeds.

## Install (Android Termux)

This repo is public, but on the phone we use Git over SSH (no HTTPS tokens):

    pkg install -y git openssh coreutils fzf
    cd ~
    rm -rf termux-client
    git clone git@github.com:cdelalama/termux-client.git
    cd termux-client
    ./install.sh

SSH auth requirement:
- ensure ~/.ssh/id_ed25519.pub is added in GitHub -> Settings -> SSH and GPG keys

Config file:
- ~/.config/termux-client/config

Optional defaults:
- DEFAULT_FOLDER: folder to open when running `vscode-web` without args (if unset, code-server may open last folder)
- code-server remembers last opened folder in ~/.local/share/code-server/coder.json on the dev-vm (302 redirect). DEFAULT_FOLDER makes it deterministic.
- Git policy: avoid force-push on main; prefer normal commits/merges so `git pull --ff-only` keeps working on phone/VM.

## New phone in 10 minutes

### 0) Installs (apps)
Install these apps first:
- Termux (from F-Droid)
- Termux:Widget (from F-Droid)
- WireGuard (Play Store / system)

### 1) One-liner (Termux)

    pkg install -y git openssh coreutils fzf && \
    cd ~ && rm -rf termux-client && \
    git clone https://github.com/cdelalama/termux-client.git && \
    cd termux-client && \
    ./install.sh && \
    bootstrap-phone

### 2) Manual steps (cannot be automated)
A) GitHub SSH key (for pushing from phone):
- Copy the printed ~/.ssh/id_ed25519.pub
- GitHub -> Settings -> SSH and GPG keys -> New SSH key

B) Android permission (for launching TMUX from shortcuts):
- Settings -> Apps -> Termux -> Display over other apps -> Allow

C) Network:
- If you are not on LAN, enable your WireGuard tunnel

### 3) Configure host (Termux)
Edit:
- ~/.config/termux-client/config

Set:
- HOST=cdelalama@10.0.0.110 (or your dev-vm IP)

Optional:
- LOCAL_PORT=18080
- REMOTE_PORT=8080

Then run: doctor-phone

### 4) Launch (2 taps)
### 4) Launch (2 taps)
After running bootstrap-phone:

- Long press Termux:Widget -> OP
  - fzf picker over projects in WORKSPACE_ROOT_REMOTE
  - opens VS Code web + attaches tmux proj_<repo> with CLOUD+CODEX

- Long press Termux:Widget -> NP
  - creates new project and attaches tmux proj_<repo> with CLOUD+CODEX

- Long press Termux:Widget -> VSCODE
  - opens code-server via SSH tunnel at http://127.0.0.1:18080

- Long press Termux:Widget -> TMUX
  - SSH + tmux new-session -A -s main

### 5) Create a project
Run:

    np

Result:
- Creates cdelalama/<repo> from template cdelalama/LLM-DocKit if missing
- Clones into ~/src/projects/<repo> on dev-vm (via BASE_DIR)
- Attaches/creates tmux session proj_<repo> with CLOUD+CODEX

## Usage

### Open an existing project (picker + VS Code + tmux)

    op

### Open an existing project (picker + VS Code + tmux)

    op

### Create / open a project tmux session

    np

### Open VS Code in browser (mobile)

    vscode-web
## Troubleshooting
Run: doctor-phone

### TMUX shortcut opens but SSH times out
- You are not on LAN and WireGuard is off, or routing is wrong.
- Quick check: from Termux run:

    ssh cdelalama@10.0.0.110

### GitHub push asks for username/token
- Your repo remote is HTTPS.
- Fix:

    git remote set-url origin git@github.com:cdelalama/termux-client.git
    ssh -T git@github.com

### Permission denied (publickey) when pushing to GitHub
- Add your phone public key to GitHub:
  - GitHub -> Settings -> SSH and GPG keys -> New SSH key
  - paste ~/.ssh/id_ed25519.pub

### newproj: command not found on dev-vm
- Install server tooling on dev-vm from cdelalama/dev-tools so /usr/local/bin/newproj exists.

### VS Code does not open
- Ensure code-server is running on dev-vm and bound to localhost:
  - pgrep -a code-server | head
  - curl -sS -D - -o /dev/null http://127.0.0.1:8080/ | head
  - ss -ltnp | grep :8080 should show 127.0.0.1:8080
- Ensure tunnel exists (Termux):

    pgrep -a ssh | grep 18080:127.0.0.1:8080
