#!/bin/sh

###########################################
#--------------) hashdisco (--------------#
#  https://github.com/hobobandy/hashdisco #
#-----------) based on LinPEAS (----------#
# https://github.com/carlospolop/PEASS-ng #
#------------) and firmwalker (-----------#
#  https://github.com/craigz28/firmwalker #
###########################################

APPNAME="hashdisco"
VERSION="0.1"
ADVISORY="This script should be used for authorized penetration testing and/or educational purposes only. Any misuse of this software will not be the responsibility of the author or of any other collaborator. Use it at your own computers and/or with the computer owner's permission."

MOTD="H4sIAHs2AGMA/31TQZLDMAi7+xV5ag897GEvTWf6wLyk2AghHLsZT+OoQgiDWzuuz99YL+wOez99HXiCkisxhl2f941nCrF972Qs0RRi4HkjNtGPnIM3UYdpovhQc+vgB9F/4SYjhUrIA0UQPLPM0ywn2bnuQFQDHifVrTH3dBCTgC3YCtNpYSfUEa/jqcqvatmUBzFzcMfBYNdwKqKwFXA/bsbsUnKknyTcrK1ulANSusHwtBzZY+BY8bKjdTm+FtKOqXqW8FO0TB/mpndwug9G6Vn7hewR3mP3gbHzQ3IesrKxY4cR2oXjEuJv7icB14iwMZaQVckOiVXMnPQShasc7IlFhgWaP5tQTRIoinBDTql0msp4Ryv5ngN/3iIluXjP9MJbfK2NyFspggnQEts/JfQn2toXrWifegkGAAA="
DEFAULT_TGT_PATH="/"
GREP_COLOR="always"
GREP_CONTEXT=25
DEBUG=0

###########################################
#---------------) Colors (----------------#
###########################################

C=$(printf '\033')
RED="${C}[1;31m"
SED_RED="${C}[1;31m&${C}[0m"
GREEN="${C}[1;32m"
SED_GREEN="${C}[1;32m&${C}[0m"
YELLOW="${C}[1;33m"
SED_YELLOW="${C}[1;33m&${C}[0m"
SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
BLUE="${C}[1;34m"
SED_BLUE="${C}[1;34m&${C}[0m"
ITALIC_BLUE="${C}[1;34m${C}[3m"
LIGHT_MAGENTA="${C}[1;95m"
SED_LIGHT_MAGENTA="${C}[1;95m&${C}[0m"
LIGHT_CYAN="${C}[1;96m"
SED_LIGHT_CYAN="${C}[1;96m&${C}[0m"
LG="${C}[1;37m" #LightGray
SED_LG="${C}[1;37m&${C}[0m"
DG="${C}[1;90m" #DarkGray
SED_DG="${C}[1;90m&${C}[0m"
NC="${C}[0m"
UNDERLINED="${C}[5m"
ITALIC="${C}[3m"

###########################################
#-----------) Helper Functions (----------#
###########################################

timestamp() {
  date +%F_%T
}

echo_text() {
  echo "$(timestamp) $@"
}

echo_debug() {
  if [ "$DEBUG" = "1" ]; then
    echo "$(timestamp) ${BLUE}DEBUG${NC} - $@"
  fi
}

echo_info() {
  echo "$(timestamp) ${GREEN}INFO${NC}  - $@"
}

echo_warn() {
  echo "$(timestamp) ${YELLOW}WARN${NC}  - $@"
}

echo_error() {
  echo "$(timestamp) ${RED}ERROR${NC} - $@"
}

grep_pattern() {
  RESULTS=$(grep --color=$GREP_COLOR -noraE ".{0,$GREP_CONTEXT}$1.{0,$GREP_CONTEXT}" $TGT_PATH | cat -)
  if [ -n "$RESULTS" ]; then
    echo_info "$2"
    echo "$RESULTS"
  fi
}

###########################################
#---------) Parsing parameters (----------#
###########################################
	
RECURSIVE=1
TGT_PATH="${DEFAULT_TGT_PATH}"
HELP="${APPNAME} ${VERSION}, simple hash discovery using regex.
Usage: $0 [OPTION]...

Options:
  -h | -?   print this help
  -c        left/right context length (default: 25 characters)
  -d        enable debug output
  -p  	    path to start search in (default: ${DEFAULT_TGT_PATH})
  -C        disable colors
  -R        disable recursive search

${ADVISORY}"

while getopts "h?c:dp:RC" opt; do
	case "$opt" in
		h|\?)   printf "%s\n" "$HELP"; exit 0;;
		c)      GREP_CONTEXT="$OPTARG";;
		d)      DEBUG=1;;
		p)      TGT_PATH="$OPTARG";;
		C)      NOCOLOR=1;;
		R)      RECURSIVE=0;;
		esac
done

# Empty out colors if requested
if [ "$NOCOLOR" ]; then
	C=""
	RED=""
	SED_RED="&"
	GREEN=""
	SED_GREEN="&"
	YELLOW=""
	SED_YELLOW="&"
	SED_RED_YELLOW="&"
	BLUE=""
	SED_BLUE="&"
	ITALIC_BLUE=""
	LIGHT_MAGENTA=""
	SED_LIGHT_MAGENTA="&"
	LIGHT_CYAN=""
	SED_LIGHT_CYAN="&"
	LG=""
	SED_LG="&"
	DG=""
	SED_DG="&"
	NC=""
	UNDERLINED=""
	ITALIC=""
	
	GREP_COLOR="never"
	echo_debug "Colors disabled."
fi

# Check if target path is valid
if [ ! -e "$TGT_PATH" ]; then
  echo_error "Target path doesn't exist, or is invalid."
  exit 1
fi

###########################################
#-----------------) MOTD (----------------#
###########################################

echo "$MOTD" | base64 -d | gunzip
echo_info "Running $APPNAME $VERSION"
echo_debug "Command ran: $0 $@"

###########################################
#----------------) Hashes (---------------#
###########################################

grep_pattern '\$1\$[./0-9A-Za-z]{0,8}\$[./0-9A-Za-z]{22}' 'md5 crypt (Cisco iOS)'
grep_pattern '\$sha1\$[0-9]{0,}\$[./0-9A-Za-z]{0,64}\$[./0-9A-Za-z]{28}' 'sha1 crypt'
grep_pattern '\$2[abxy]?\$[0-9][0-9]\$[./A-Za-z0-9]{21}[.Oeu][./A-Za-z0-9]{31}' 'Bcrypt'
grep_pattern '\$5\$(rounds=[0-9]+\$)?[./0-9A-Za-z]{0,16}\$[./0-9A-Za-z]{43}' 'sha256 crypt'
grep_pattern '\$6\$(rounds=[0-9]+\$)?[./0-9A-Za-z]{0,16}\$[./0-9A-Za-z]{43}' 'sha512 crypt'
grep_pattern '\$md5([$,]rounds=[0-9]+)?\$[./0-9A-Za-z]{0,8}\$\$[./0-9A-Za-z]{22}' 'sun md5 crypt + variant'
grep_pattern '\$3\$\$[A-Fa-f0-9]{32}' 'NT Hash (FreeBSD)'
grep_pattern 'crypt\$[a-f0-9]{5}\$[./0-9A-Za-z]{13}' 'django des crypt'
grep_pattern 'sha1\$[a-f0-9]{0,64}\$[./0-9a-f]{40}' 'django sha1 (un)salted'
grep_pattern 'md5\$[a-f0-9]{0,64}\$[./0-9a-f]{32}' 'django md5 (un)salted'
grep_pattern 'pbkdf2_sha256\$[0-9]*\$[0-9a-zA-Z]+\$[a-zA-Z0-9\/+=]{44}' 'django pbkdf2 sha256'
grep_pattern 'pbkdf2_sha1\$[0-9]*\$[0-9a-zA-Z]{0,64}\$[./0-9A-Za-z]{28}' 'django pbkdf2 sha1'
grep_pattern 'bcrypt\$?\$2[abxy]?\$[0-9][0-9]\$[./A-Za-z0-9]{21}[.Oeu][./A-Za-z0-9]{31}' 'django bcrypt'
grep_pattern 'bcrypt_sha256\$?\$2[abxy]?\$[0-9][0-9]\$[./A-Za-z0-9]{21}[.Oeu][./A-Za-z0-9]{31}' 'django bcrypt sha256'

exit 0