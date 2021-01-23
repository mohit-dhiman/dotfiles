# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mohit/Ameyo/tools/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/mohit/Ameyo/tools/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mohit/Ameyo/tools/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mohit/Ameyo/tools/fzf/shell/key-bindings.bash"
export FZF_COMPLETION_TRIGGER='``'
fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf-tmux -d 15 +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}
