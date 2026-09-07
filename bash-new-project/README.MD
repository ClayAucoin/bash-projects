# np

This script creates a new project folder structure inside your `~/projects` directory. It sets up common web project files, directories, and boilerplate automatically.

## Overview

The script helps you quickly scaffold a new project with:

- A predefined directory structure (`css`, `js`, `images`, `.github/workflows`)
- Common helper files and templates downloaded automatically
- An initialized Git repository with an initial commit

## Usage

Run the command in Git Bash:

```bash
np my-project
```

This creates the project folder at:

```text
~/projects/my-project/
```

You can replace `my-project` with any desired subdirectory path, such as:

```bash
np movie-scripts/movie-watchlist
```

This would create:

```text
~/projects/movie-scripts/movie-watchlist/
```

## Structure

After running the script, your project folder will look like this:

```text
my-project/
├── index.html
├── README.md
├── .gitignore
├── css/
│   ├── modal-html-style.css
│   └── style.css
├── images/
│   └── favicon.ico
├── js/
│   ├── helpers-full.js
│   ├── helpers-old.js
│   ├── modal-html.js
│   ├── my-helpers.js
│   ├── variables.js
│   ├── script.js
│   ├── secret-variables.js
│   └── app.js
└── .github/
    └── workflows/
        └── pages.yml
```

## What It Does

1. Creates all required directories and files.
2. Downloads CSS, JavaScript, and GitHub workflow files from GitHub.
3. Creates a `.gitignore` with sensible defaults.
4. Initializes a Git repository.
5. Creates an initial commit with the commit message `init`.

## Prerequisites

- **Git Bash** on Windows, or a compatible Bash environment
- **Git**
- **curl**
- Internet connection to download the template files

## Installation

The actual script is stored at:

```text
~/projects/bash-projects/bash-new-project/np
```

The `np` command is provided by a launcher script located at:

```text
~/bin/np
```

The launcher runs the repository version of `np`, allowing the command to be used from anywhere in Git Bash.

Installation instructions for the launcher are available in the main [bash-projects README](https://github.com/ClayAucoin/bash-projects).

## Notes

- The script uses `~/projects` as the base directory for newly created projects.
- Subdirectories can be included in the project name, such as `movie-scripts/movie-watchlist`.
- The actual script remains inside the `bash-projects` Git repository, so changes to the repository version of `np` are immediately used the next time the command is run.
- There is no need to copy the actual script into `~/bin`.

## License

This script is provided freely for personal and educational use.
