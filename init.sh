export SHELL_NAME="$(echo $0 | grep -oh '[a-z]*$')"
export OS="$(uname | tr "[A-Z]" "[a-z]")"
export cfg="${HOME}/.config/personal"
export cfg_sh="${cfg}/sh"

# files each
declare -a TARGET_FILES=("aliases.sh" "utils.sh"  "environment.sh"   "options.sh" "functions.sh" "init.sh")

if [ "${1}" = "skip" ]; then
  declare -a TARGET_FILES=("utils.sh" "environment.sh")
fi

# allow various envionment differences: base, os & shell
declare -a ENV_CONDS=("base" "os/$OS" "shell/$SHELL_NAME")

# allow local overrides
declare -a TARGETS=("default" "local")

for TARGET_FILE in ${TARGET_FILES[@]}; do
  for ENV_COND in ${ENV_CONDS[@]}; do
    for TARGET in ${TARGETS[@]}; do
      FILE="${cfg_sh}/${TARGET}/${ENV_COND}/${TARGET_FILE}"
      [ -e "$FILE" ] && source "$FILE"
    done 
  done
done 

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
