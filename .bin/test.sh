test() {
  read -p "Are you ok ? (y/n): " DATA
  case "$DATA" in
    [yY]) echo "$ask_zsh1" ;;
    [nN]) echo "NG" ;;
    *) echo "Push y or n key."
  esac
}

echo "$test"
