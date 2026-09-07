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
  # echo "Changing directory to: $target"
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
  # echo "  4) Run tests (npm test)"
  echo "  4) Open in VS Code and show git status"

  echo
  read -rp "Choose an action [1]: " action
  action=${action:-1}

  echo

  case "$action" in
    1)
      # echo "Done. You are in: $(pwd)"
      ;;
    2)
      echo "Opening VS Code..."
      code . 2>/dev/null || echo "Could not run 'code .'. Make sure VS Code is installed and 'code' is on your PATH."
      cd ../
      ;;
    3)
      echo "Running: git status"
      git status || echo "Not a git repository or git not available."
      ;;
    # 4)
    #   echo "Running: npm test"
    #   npm test || echo "npm test failed or npm is not available."
    #   ;;
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
  # ls
}
