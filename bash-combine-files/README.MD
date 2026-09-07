# Combine Files

## Overview

`combine` is a Bash utility that combines the contents of files with specified extensions in the current directory and its subdirectories into a single text file.

It is designed primarily for **Git Bash on Windows**.

The script:

- Asks which file extensions to include, such as `jsx`, `css`, `js`, or `py`.
- Recursively searches the current directory and its subdirectories for matching files.
- Skips the `node_modules` directory.
- Writes each file's **relative path** followed by its **contents**.
- Separates files for easier reading.
- Automatically creates an output filename based on the current directory and selected extensions.

For example:

```text id="y3t5lr"
contents-of-lv3capstone-jsx-css.txt
```

## Example Output

If your project contains:

```text id="l3sld1"
src/App.jsx
src/App.css
src/components/Navbar.jsx
src/components/Navbar.css
```

and you choose `jsx` and `css`, the generated file will contain something similar to:

```text id="fs1opz"
src/App.jsx

...App.jsx contents...


src/App.css

...App.css contents...


src/components/Navbar.jsx

...Navbar.jsx contents...


src/components/Navbar.css

...Navbar.css contents...
```

## Usage

Navigate to the project or directory containing the files you want to combine:

```bash id="pp2nyb"
cd /c/path/to/your/project
```

Run:

```bash id="qf6lgw"
combine
```

Enter each extension when prompted, without the leading dot:

```text id="ezljzm"
Extension to include (or '-' for no more): jsx
Extension to include (or '-' for no more): css
Extension to include (or '-' for no more): -
```

The script recursively collects the matching files and creates an output file in the current directory.

For example:

```text id="i24v68"
contents-of-myproject-jsx-css.txt
```

## Example Run

```text id="id7sbm"
$ cd /c/Users/Administrator/projects/lv3-capstone

$ combine

This script will combine file contents from the current directory (recursively).

Enter extensions to include (without the dot). Type '-' when finished.

Extension to include (or '-' for no more): jsx
Extension to include (or '-' for no more): css
Extension to include (or '-' for no more): -

Collecting files (excluding node_modules)...

Done. Wrote: contents-of-lv3capstone-jsx-css.txt
```

## Features

- Recursively processes files in the current directory and its subdirectories.
- Supports multiple file extensions in a single run.
- Automatically skips the `node_modules` directory.
- Includes each file's relative path in the output.
- Uses clear separation between files.
- Automatically names the output file based on the current directory and selected extensions.
- Replaces an existing output file with the same name.

## Installation

The actual `combine` script is stored in the `bash-projects` repository at:

```text id="z6iyrx"
~/projects/bash-projects/bash-combine-files/combine
```

The command is provided by a launcher located at:

```text id="25twcb"
~/bin/combine
```

The launcher runs the repository version of `combine`, allowing the command to be used from anywhere in Git Bash.

Installation and launcher setup instructions are available in the main [bash-projects README](https://github.com/ClayAucoin/bash-projects).

## How It Works

When you run:

```bash id="u21sjv"
combine
```

Git Bash finds:

```text id="7cm9oz"
~/bin/combine
```

That launcher runs the actual script stored in:

```text id="fsnrp7"
~/projects/bash-projects/bash-combine-files/combine
```

This keeps the actual program inside the Git repository rather than maintaining a separate copy in `~/bin`.

Any changes made to the repository version of `combine` are therefore used automatically the next time the command is run.

## Prerequisites

- **Git Bash** on Windows, or a compatible Bash environment
- `~/bin` configured in your `PATH`

See the main repository README for the complete installation instructions.

## License

This script is provided freely for personal and educational use.
