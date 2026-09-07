# Bash Projects

A collection of small Bash utilities I use to simplify common development tasks.

These scripts are designed primarily for **Git Bash on Windows**. The actual scripts live inside this Git repository, while small launcher scripts in `~/bin` make the commands available from anywhere in Git Bash.

## Included Utilities

| Command   | Project                                                                                        | Description                                                               |
| --------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `np`      | [bash-new-project](https://github.com/ClayAucoin/bash-projects/tree/main/bash-new-project)     | Creates and initializes new projects inside `~/projects`.                 |
| `proj`    | [bash-dir-list-proj](https://github.com/ClayAucoin/bash-projects/tree/main/bash-dir-list-proj) | Provides quick project selection, navigation, and common project actions. |
| `combine` | [bash-combine-files](https://github.com/ClayAucoin/bash-projects/tree/main/bash-combine-files) | Combines selected project files into a single text file.                  |

See each project's README for complete usage instructions and project-specific documentation.

# Installation

## 1. Clone the Repository

Clone the repository into `~/projects`:

```bash
cd ~/projects
git clone https://github.com/ClayAucoin/bash-projects.git
```

This creates:

```text
~/projects/bash-projects/
```

## 2. Make the Project Scripts Executable

```bash
chmod +x ~/projects/bash-projects/bash-new-project/newproject.sh \
         ~/projects/bash-projects/bash-dir-list-proj/proj.sh \
         ~/projects/bash-projects/bash-combine-files/combine.sh
```

## 3. Create the `~/bin` Directory

Create the directory if it does not already exist:

```bash
mkdir -p ~/bin
```

`~/bin` must be in your `PATH` for the commands to work from anywhere.

You can check with:

```bash
echo "$PATH"
```

## 4. Create the Launcher Scripts

The launcher scripts provide the short `np`, `proj`, and `combine` commands while keeping the actual program code inside the Git repository.

### `np`

```bash
cat > ~/bin/np <<'EOF'
#!/usr/bin/env bash
~/projects/bash-projects/bash-new-project/newproject.sh "$@"
EOF
```

### `proj`

```bash
cat > ~/bin/proj <<'EOF'
#!/usr/bin/env bash
~/projects/bash-projects/bash-dir-list-proj/proj.sh "$@"
EOF
```

### `combine`

```bash
cat > ~/bin/combine <<'EOF'
#!/usr/bin/env bash
~/projects/bash-projects/bash-combine-files/combine.sh "$@"
EOF
```

Make the launchers executable:

```bash
chmod +x ~/bin/np ~/bin/proj ~/bin/combine
```

# How the Launchers Work

The files in `~/bin` are only launchers. The actual programs remain in the Git repository:

```text
~/bin/np
    → ~/projects/bash-projects/bash-new-project/newproject.sh

~/bin/proj
    → ~/projects/bash-projects/bash-dir-list-proj/proj.sh

~/bin/combine
    → ~/projects/bash-projects/bash-combine-files/combine.sh
```

Each launcher passes any supplied command-line arguments to the actual script using:

```bash
"$@"
```

This means there is only one copy of the actual program code to maintain.

Changes made to the scripts inside `~/projects/bash-projects` are automatically used the next time the corresponding command is run.

# Verify the Installation

Check that Git Bash can find all three commands:

```bash
which np
which proj
which combine
```

On Windows with Git Bash, the results should look similar to:

```text
/c/Users/Administrator/bin/np
/c/Users/Administrator/bin/proj
/c/Users/Administrator/bin/combine
```

You can then test each command:

```bash
np
proj
combine
```

# Updating

Because the actual scripts are executed directly from the repository, updating all three utilities only requires updating the repository:

```bash
cd ~/projects/bash-projects
git pull
```

There is no need to copy updated scripts into `~/bin`.

The launcher scripts only need to be recreated if their command names or the locations of the underlying scripts change.

# Repository Structure

```text
bash-projects/
├── bash-combine-files/
│   ├── combine.sh
│   └── README.md
│
├── bash-dir-list-proj/
│   ├── proj.sh
│   └── README.md
│
├── bash-new-project/
│   ├── newproject.sh
│   └── README.md
│
└── README.md
```

Each project directory contains its own README with complete documentation for that utility.

## Repository

[ClayAucoin/bash-projects](https://github.com/ClayAucoin/bash-projects)
