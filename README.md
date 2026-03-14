# Git Sync Quick Command

A small helper command for automating common Git sync steps.

Current script in this repo:
- `git-sync.bat` (Windows batch script)

## What `git-sync.bat` does

When you run `git-sync`, it will:
1. Stage all changes (`git add -A`)
2. Stash current work (`git stash push -m "..."`)
3. Detect your default remote branch from `origin/HEAD`
4. Pull latest changes (`git pull`)
5. Merge `origin/<default-branch>` with `--no-ff --no-edit`
6. Show status (`git status`)
7. Push changes (`git push`)
8. Print manual next steps to re-apply and drop the stash

## Requirements

- Git installed and available in PATH
- A Git repository with a configured `origin` remote
- Windows Command Prompt or PowerShell for `.bat` execution

## Usage

Run from inside a Git repository:

```powershell
git-sync
```

Custom stash message:

```powershell
git-sync -m "my temporary stash message"
```

Help:

```powershell
git-sync -h
```

## Add command to PATH (Windows)

Important: PATH stores directories, not individual files.

You have two practical setup options.

### Option A: Single file setup

Use this when you only want `git-sync.bat` available.

1. Create a folder, for example:
   - `C:\Users\<YourUser>\bin`
2. Put `git-sync.bat` inside that folder.
3. Add that folder to your user PATH:
   - Start menu -> search `Environment Variables`
   - Open `Edit the system environment variables`
   - Click `Environment Variables...`
   - Under `User variables`, select `Path` -> `Edit`
   - Click `New` and add `C:\Users\<YourUser>\bin`
4. Open a new terminal and run:

```powershell
git-sync -h
```

### Option B: Entire folder setup (recommended for many quick commands)

Use this when you plan to keep multiple Git helper scripts in one folder.

1. Keep all scripts together, for example:
   - `D:\Programs\bat`
2. Add that folder to your user PATH (same steps as Option A).
3. Open a new terminal.
4. Run any command file in that folder by name (for example `git-sync`).

This is the best setup for an "auto git quick commands" toolbox.

## Linux and macOS

`git-sync.bat` is a Windows batch file and does not run natively in Linux/macOS shells.

If you want equivalent behavior on Linux/macOS:
1. Create a shell version (for example `git-sync.sh`) with equivalent Git commands.
2. Make it executable:

```bash
chmod +x git-sync.sh
```

3. Add its folder to PATH in your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
export PATH="$PATH:/path/to/your/scripts"
```

4. Reload shell config:

```bash
source ~/.bashrc
# or
source ~/.zshrc
```

## Verify your setup

### Windows

```powershell
where git-sync
```

### Linux/macOS

```bash
which git-sync
```

## Notes

- If `git-sync` is not found, close and reopen your terminal after PATH changes.
- The script stashes local changes first. Review the printed "Next steps" after it completes.
- If your workflow requires rebasing instead of merge commits, adjust the script accordingly.
