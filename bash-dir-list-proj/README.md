# proj --- A Simple Project Picker for Git Bash

`proj` is a small helper function you can add to your `~/.bashrc` that lets you quickly jump into any sub-project in the current directory and optionally run common actions like opening the folder in VS Code or checking git status.

This tool is ideal for directories that contain multiple project folders, such as:

    ~/class/projects/lv4/
      ├── lv4-api-first-server
      ├── lv4-api-server-backend
      ├── lv4-api-server-backend-redo
      ├── lv4-api-server-frontend
      └── ...

Instead of typing paths over and over, you run `proj`, choose a number, and get to work immediately.

---

## Features

### ✔ Lists subdirectories in the current folder

Each directory is displayed with a number so you can pick it quickly.

### ✔ Jump into a directory by choosing its number

No need to type long folder names manually.

### ✔ Optional per-project actions

After entering a project, you can choose to:

1.  Just enter the directory\
2.  Open it in VS Code\
3.  Show `git status`\
4.  Open in VS Code and run `git status`

### ✔ Works directly in your shell

Since `proj` is a function and not a script, `cd` actually changes the directory in your current terminal session.

---

## Installation

1.  Open your Git Bash terminal.
2.  Edit your `.bashrc` file:

```bash
nano ~/.bashrc
```

3.  Paste the `proj` function into the file.
4.  Save and reload your shell:

```bash
source ~/.bashrc
```

Now the `proj` command is available in every session.

---

## Usage

Navigate to a directory that contains project folders:

```bash
cd ~/class/projects/lv4
```

Run:

```bash
proj
```

You'll see something like:

    Current directory: /home/you/class/projects/lv4

    Subdirectories:

      1. lv4-api-first-server
      2. lv4-api-server-backend
      3. lv4-api-server-backend-redo
      4. lv4-api-server-frontend

    Choose a directory by number (or 'q' to cancel):

After selecting a directory, the action menu appears:

    What would you like to do?

      1) Just change directory (do nothing else)
      2) Open in VS Code (code .)
      3) Show git status
      4) Open in VS Code and show git status

Choose an action, and you're ready to work.

---

## The proj Function

```bash
proj() {
  dirs=(*/)

  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "No subdirectories found."
    return 1
  fi

  echo "Current directory: $(pwd)"
  echo
  echo "Subdirectories:"
  echo
  for i in "${!dirs[@]}"; do
    printf "  %2d. %s\n" "$((i + 1))" "${dirs[$i]%/}"
  done

  echo
  read -rp "Choose a directory by number (or 'q' to cancel): " choice

  if [[ "$choice" =~ ^[Qq]$ ]]; then
    echo "Cancelled."
    return 0
  fi

  if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
    echo "Error: '$choice' is not a number."
    return 1
  fi

  index=$((choice - 1))

  if (( index < 0 || index >= ${#dirs[@]} )); then
    echo "Error: choice out of range."
    return 1
  fi

  target="${dirs[$index]}"
  cd "$target" || {
    echo "Error: failed to cd into '$target'."
    return 1
  }

  echo
  echo "Now in: $(pwd)"
  echo

  echo "What would you like to do?"
  echo
  echo "  1) Just change directory (do nothing else)"
  echo "  2) Open in VS Code (code .)"
  echo "  3) Show git status"
  echo "  4) Open in VS Code and show git status"

  echo
  read -rp "Choose an action [1]: " action
  action=${action:-1}

  echo

  case "$action" in
    1)
      ;;
    2)
      echo "Opening VS Code..."
      code . 2>/dev/null || echo "Could not run 'code .'. Make sure VS Code is installed and 'code' is on your PATH."
      ;;
    3)
      echo "Running: git status"
      git status || echo "Not a git repository or git not available."
      ;;
    4)
      echo "Opening VS Code..."
      code . 2>/dev/null || echo "Could not run 'code .'. Make sure VS Code is installed and 'code' is on your PATH."
      echo
      echo "Running: git status"
      git status || echo "Not a git repository or git not available."
      ;;
    *)
      echo "Unknown action '$action'. Doing nothing extra."
      ;;
  esac

  echo
}
```

---

## Notes

- The script relies on `code` being available on your PATH.\ In VS Code, enable this under **Command Palette → "Shell Command: Install 'code' command in PATH"**.
- This function is meant to be run from a directory containing only project folders.\ If you mix files and folders, only folders will be listed.

---

## Future Ideas

- Auto-detect Node projects (`package.json`) and show project-specific actions\
- Add "Run dev server" for React/Vite projects\
- Add fuzzy search by folder name\
- Add bookmarking ("favorite projects")
