# --- User@machine---
local user_machine_prompt="%{$terminfo[bold]$fg[green]%} %n@%m%{$reset_color%}  "

# -- Location ---
local location_prompt="%{$fg[yellow]%} %~%{$reset_color%}  "

# --- Git ---
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}   "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}   "

# --- Virtualenv ---
VIRTUAL_ENV_DISABLE_PROMPT=1 # Prevent default venv prompt prefix
local venv_info='$(virtenv_prompt)'
virtenv_prompt() {
  [[ -n "${VIRTUAL_ENV:-}" ]] || return
  echo -n "%{$fg[green]%}󰌠 ${VIRTUAL_ENV} %{$reset_color%}"
}

# --- Charm ---
local charm_prompt="%{$terminfo[bold]$fg[green]%}> %{$reset_color%}"

# --- Prompt ---
PROMPT="${user_machine_prompt}${location_prompt}${git_info}${venv_info}
$charm_prompt"

# --- Duration ---
zmodload zsh/datetime 2>/dev/null

typeset -g __START_TIME
preexec() {
  __START_TIME=$EPOCHREALTIME
}
precmd() {
  local last_exit_code=$?
  local last_command=$(fc -ln -1)
  if [ "$DURATION" != "1" ]; then
    if [[ "$last_command" != "clear" && -n "$last_command" ]]; then
      print ""
    fi
    return
  fi
  
  [[ "$last_command" == "clear" ]] && return
  if [[ -n $__START_TIME ]]; then
    local time_end=$EPOCHREALTIME
    local diff=$(printf '%.4f' "$(echo "$time_end - $__START_TIME" | bc)")
    local total_ms=$(printf '%.0f' "$(echo "$diff * 1000" | bc)")
    local hours=$(( total_ms / 3600000 ))
    local minutes=$(( (total_ms % 3600000) / 60000 ))
    local seconds=$(( (total_ms % 60000) / 1000 ))
    local millis=$(( total_ms % 1000 ))

    local time_elapsed_pretty=""
    (( hours > 0 ))   && time_elapsed_pretty+="${hours}h "
    (( minutes > 0 )) && time_elapsed_pretty+="${minutes}m "
    (( seconds > 0 )) && time_elapsed_pretty+="${seconds}s "
    if (( hours == 0 && minutes == 0 && seconds == 0 && millis == 0 )); then
      time_elapsed_pretty="0ms"
    elif (( millis > 0 )); then
      time_elapsed_pretty+="${millis}ms"
    fi
    local time_start_pretty=$(date -r ${__START_TIME%.*} +'%H:%M:%S')
    local time_end_pretty=$(date -r ${time_end%.*} +'%H:%M:%S')

    local time_info="\033[34m󰅐 $time_start_pretty  $time_end_pretty\033[0m"
    local duration_info="\033[35m󰔛 $time_elapsed_pretty\033[0m"
    local exit_code_color
    if [[ $last_exit_code -eq 0 ]]; then
      exit_code_color="\033[32m"  # green
    else
      exit_code_color="\033[31m"  # red
    fi
    local exit_code_info="${exit_code_color} $last_exit_code\033[0m"
    print "$time_info  $duration_info  $exit_code_info\n"
  fi
}
