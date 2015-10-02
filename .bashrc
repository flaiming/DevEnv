EDITOR=vim
export LC_ALL="en_US.utf8"
#export WORKON_HOME=/www
#source /usr/local/bin/virtualenvwrapper.sh

# # Define some colors first:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
mag='\e[0;95m'
MAG='\e[0;45m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
yellowb='\e[43m'
green='\e[0;92m'
GREEN='\e[1;32m'
greenb='\e[42m'
MAG='\e[0;45m'
NC='\e[0m'              # No Color
# # --> Nice. Has the same effect as using "ansi.sys" in DOS.

PROMPTCOL=$aqua
DIRCOL=$yellowb
GITCOL=$YELLOW

TITLEBAR='\[\e]0;\u@`hostname`\a\]'

export PS1="${TITLEBAR}\[$PROMPTCOL\][\u@`hostname`] \[$DIRCOL\]\w \[$GITCOL\]\$(vcprompt --format-git %b) \[$DIRCOL\]\$\[$NC\] "
# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lh'
alias l='ls $LS_OPTIONS -lAh'
alias grep='grep --color=auto --colour=auto'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias df='df -h'
alias du='du -h'

### Python source control
alias apep='autopep8 -ia --max-line-length=200'
alias apepall='autopep8 -ira --max-line-length=200 .'
alias plr='pep8 --repeat --ignore=E501'
function pp()
{
    if [ -z "$1" ]
    then
        echo "Insert filename."
        return
    fi

    plr $1
    pyflakes $1
}

### Search utils
function gall()
{
    if [ -z "$2" ]
    then
        grep $1 . -rn
    else
        grep $1 . -rn -A $2 -B $2
    fi  
}

function gpy()
{
    if [ -z "$2" ]
    then
        grep --include="*.py" $1 . -rn
    else
        grep --include="*.py" $1 . -rn -A $2 -B $2
    fi  
}

function ghtml()
{
    if [ -z "$2" ]
    then
        grep --include="*.html" $1 . -rn
    else
        grep --include="*.html" $1 . -rn -A $2 -B $2
    fi  
}

function gch()
{
    if [ -z "$2" ]
    then
        grep --include=*.{c,cc,cpp,h} $1 . -rn
    else
        grep --include=*.{c,cc,cpp,h} $1 . -rn -A $2 -B $2
    fi  
}

function gconf()
{
    if [ -z "$2" ]
    then
        grep --include=*.{conf,cfg} $1 . -rn
    else
        grep --include=*.{conf,cfg} $1 . -rn -A $2 -B $2
    fi  
}
function gjs()
{
    if [ -z "$2" ]
    then
        grep --include="*.js" $1 . -rn
    else
        grep --include="*.js" $1 . -rn -A $2 -B $2
    fi  
}
function gcss()
{
    if [ -z "$2" ]
    then
        grep --include="*.css" $1 . -rn
    else
        grep --include="*.css" $1 . -rn -A $2 -B $2
    fi  
}

function ff()
{ 
    find . -name '*'$1'*'
}

function apts()
{ 
    aptitude search $1
}
function apti()
{ 
    aptitude install $1
}

#----------------------
# SVN/GIT stuff
#----------------------
alias gigraph='git log --graph --decorate --pretty=oneline --abbrev-commit'

alias gidiff='git diff | view -'
alias gidiffc='git diff --cached | view -'
alias gidifff='git diff --name-only HEAD..origin/HEAD'
alias gic='git checkout'
alias gicb='git checkout -b'
alias gidb='git branch -D'
alias b='git branch -va'
alias giadd='git add -A'
alias gir='git reset '
alias gich='git checkout -- '
alias s='st'


function st()
{
    git status
}
function stu()
{
    git remote show origin | grep "Fetch.URL"
    git status
}

function up()
{
    if [ -e .svn ]
    then
        svn up
    else
        git fetch -p
        git pull $@
    fi
}

function svdiff()
{
    if [ -e .svn ]
    then
        svn diff | view -
    else
        git diff | view -
    fi
}

#-----------------------
# Greeting, motd etc...
# #-----------------------
#

#-----------------------
# Usefull commands
# #-----------------------
#
#
# Replace string in all files in folder recursively
# grep -rl 'windows' ./ | xargs sed -i 's/windows/linux/g'
#
# Replace string in file names
# for i in szn-firmy-searchweb.* ; do mv "$i" "${i/searchweb/userweb}" ; done
#
# Edit crontab vith VIM as a root
# sudo env EDITOR=vim crontab -e -u root



# function for multipurpose extracting
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
if [ -f $1 ] ; then
        NAME=${1%.*}
        mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2) tar xvjf ../$1 ;;
          *.tar.gz) tar xvzf ../$1 ;;
          *.tar.xz) tar xvJf ../$1 ;;
          *.lzma) unlzma ../$1 ;;
          *.bz2) bunzip2 ../$1 ;;
          *.rar) unrar x -ad ../$1 ;;
          *.gz) gunzip ../$1 ;;
          *.tar) tar xvf ../$1 ;;
          *.tbz2) tar xvjf ../$1 ;;
          *.tgz) tar xvzf ../$1 ;;
          *.zip) unzip ../$1 ;;
          *.Z) uncompress ../$1 ;;
          *.7z) 7z x ../$1 ;;
          *.xz) unxz ../$1 ;;
          *.exe) cabextract ../$1 ;;
          *) echo "extract: '$1' - unknown archive method" ;;
        esac
else
echo "$1 - file does not exist"
    fi
fi
}

