#-----------------------------------------------------------------------------
#  bashrc v. 20230517.1
#  Run control file for interactive bash shells, sourced by .bash_profile
#-----------------------------------------------------------------------------

# Bail here if not running interactively
case $- in
  *i*) ;;
    *) return;;
esac

# Not visible to non-login shells if defined in bash_profile, so define here
export BASH_CFG_D="$HOME/.config/bash"

# Used in prompt customization. No need to export; this file is sourced by all
# interactive shells.
color_prompt=true
multiline_prompt=true


#-----------------------------------------------------------------------------
# ->  Shell options
#     - set = POSIX options (see profile)
#     - shopt = bash options
#-----------------------------------------------------------------------------
# Infer 'cd' from directory name
shopt	-s autocd

# Update LINES and COLUMNS variables after each commend
shopt	-s checkwinsize

# Enable *() +() ?() @() !() glob patterns
shopt	-s extglob


#-----------------------------------------------------------------------------
# ->  CDPATH
#-----------------------------------------------------------------------------
# Omit leading '../' when cd'ing to sibling directories
export CDPATH=".."
# grep -Eq "(^|:)\.\.(:|$)" <<< "$CDPATH" || CDPATH=".."${CDPATH+:$CDPATH}


#-----------------------------------------------------------------------------
# ->  Function definitions
#-----------------------------------------------------------------------------
# Source all files in funcs.d subdirectory
# To exclude a file, prepend a '^' or append any char to '.sh'
for file in "$BASH_CFG_D/funcs.d"/[^^]*.sh; do
	if [[ -r "$file" ]]; then source "$file" &>/dev/null; fi
done


#-----------------------------------------------------------------------------
# ->  Aliases
#-----------------------------------------------------------------------------
if [[ -r "$BASH_CFG_D/bash_aliases" ]]; then
  source "$BASH_CFG_D/bash_aliases" &>/dev/null
fi


#-----------------------------------------------------------------------------
# ->  Prompt customization
#-----------------------------------------------------------------------------
# Defined in funcs.d/psfuncs.sh; executed each time before main prompt printed
PROMPT_COMMAND=refresh_prompts
