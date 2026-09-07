# proj - Project Picker for Git Bash

`proj` is a Bash utility for quickly selecting and navigating into a subdirectory without repeatedly typing long project paths.

It is designed primarily for **Git Bash on Windows**.

This is especially useful for directories containing multiple projects, such as:

```text id="mavnhu"
~/class/projects/lv4/
├── lv4-api-first-server/
├── lv4-api-server-backend/
├── lv4-api-server-backend-redo/
├── lv4-api-server-frontend/
└── ...
```

Instead of typing a complete directory name, run `proj`, choose a project by number, and select what you want to do with it.

## Features

### Lists Subdirectories

`proj` displays the subdirectories of your current directory as a numbered list.

### Select by Number

Choose a directory by entering its corresponding number instead of typing the full folder name.

### Project Actions

After selecting a project, you can choose from several common actions:

1. Just enter the directory
2. Open the project in VS Code
3. Show `git status`
4. Open the project in VS Code and show `git status`

### Changes Your Current Directory

Unlike a normal standalone Bash script, `proj` is sourced into the current shell through a small function in `~/.bashrc`.

This allows `proj` to change the working directory of the Git Bash session you're currently using.

## Usage

Navigate to a directory containing your projects:

```bash id="y83hqh"
cd ~/class/projects/lv4
```

Run:

```bash id="ap1t0s"
proj
```

You'll see a list similar to:

```text id="mpo7d1"
Current directory: /c/Users/Administrator/class/projects/lv4

Subdirectories:

   1. lv4-api-first-server
   2. lv4-api-server-backend
   3. lv4-api-server-backend-redo
   4. lv4-api-server-frontend

Choose a directory by number (or 'q' to cancel):
```

After selecting a directory, the action menu appears:

```text id="28km9x"
What would you like to do?

  1) Just change directory (do nothing else)
  2) Open in VS Code (code .)
  3) Show git status
  4) Open in VS Code and show git status
```

Choose an action and `proj` handles the rest.

## Installation

The actual `proj` script is stored in the `bash-projects` repository at:

```text id="cj76yh"
~/projects/bash-projects/bash-dir-list-proj/proj
```

Because `proj` needs to change the current shell's working directory, it is sourced through a small function in `~/.bashrc` rather than launched as a normal executable from `~/bin`.

Add the following to `~/.bashrc`:

```bash id="ajik02"
proj() {
  source ~/projects/bash-projects/bash-dir-list-proj/proj "$@"
}
```

Reload the Bash configuration:

```bash id="35vuwp"
source ~/.bashrc
```

The `proj` command will then be available in Git Bash:

```bash id="13mkyy"
proj
```

Complete repository setup instructions are available in the main [bash-projects README](https://github.com/ClayAucoin/bash-projects).

## Why `proj` Uses a Bash Function

The other utilities in this repository, such as `np` and `combine`, can use executable launchers in `~/bin`.

`proj` is different because it needs to change the working directory of the current terminal.

A normal Bash script runs in a separate child process. If that script runs:

```bash id="pyu7ip"
cd some-project
```

the directory changes only inside that child process. When the script exits, the original Git Bash session remains in its previous directory.

The small `proj()` function in `~/.bashrc` solves this by sourcing the repository script:

```bash id="dyyv3p"
source ~/projects/bash-projects/bash-dir-list-proj/proj "$@"
```

This executes the repository script inside the current Bash session, allowing `cd` to affect the terminal you're actually using.

The program itself remains in the Git repository, so there is only one copy of the `proj` logic to maintain.

## Prerequisites

- **Git Bash** on Windows, or a compatible Bash environment
- **Git** for the `git status` actions
- **Visual Studio Code** with the `code` command available in your `PATH` for the VS Code actions

Git and VS Code are only required for their corresponding menu actions.

## VS Code Support

The VS Code actions use:

```bash id="u9lfrj"
code .
```

You can verify that the VS Code command is available by running:

```bash id="ex6lj7"
code --version
```

If that command works, `proj` should be able to open selected projects in VS Code.

## Notes

- Run `proj` from a directory containing the project folders you want to choose from.
- Only directories are included in the selection list. Regular files are ignored.
- Enter `q` at the project-selection prompt to cancel.
- The actual program code is maintained in the `bash-projects` Git repository.
- The `~/.bashrc` function contains only the code necessary to source the repository script.
- Changes committed or pulled into the repository version of `proj` are automatically used the next time `proj` runs.

## Future Ideas

Possible future enhancements include:

- Auto-detect Node projects using `package.json` and provide project-specific actions.
- Add an option to start a React/Vite development server.
- Add fuzzy searching by project name.
- Add bookmarks or favorite projects.

## License

This script is provided freely for personal and educational use.
