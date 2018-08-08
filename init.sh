
export SHELL_NAME="$(echo $SHELL | grep -o '[^/]*$')"
export OS="$(uname | tr "[A-Z]" "[a-z]")"
export cfg="${HOME}/.config/personal"
export cfg_sh="${cfg}/sh"

# files each
TARGET_FILES=("utils.sh" "environment.sh" "options.sh" "aliases.sh" "functions.sh" "init.sh")

if [ "${1}" = "skip" ]; then
  TARGET_FILES=("utils.sh" "environment.sh")
fi

# allow various envionment differences: base, os & shell
ENV_CONDS=("base" "os/$OS" "shell/$SHELL_NAME")

# allow local overrides
TARGETS=("default" "local")

for TARGET_FILE in ${TARGET_FILES[@]}; do
  for ENV_COND in ${ENV_CONDS[@]}; do
    for TARGET in ${TARGETS[@]}; do
      source "${cfg_sh}/${TARGET}/${ENV_COND}/${TARGET_FILE}" 2> /dev/null
    done
  done
done
