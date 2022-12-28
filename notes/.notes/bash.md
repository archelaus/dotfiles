### [GNU Bash](https://www.gnu.org/software/bash/) FAQ

---

1. User confirmation?


```
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
fi
```

```
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
```

- Use case/esac

```
read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
```

- Function

```
function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}
```

```
[[ -f ./${sname} ]] && read -p "File exists. Are you sure? " -n 1

[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
```

[Source](https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script)

2. Replace $HOME with ~ (tilde)

`echo ${PWD/#$HOME/'~'}`

`pwd | sed "s|^$HOME|~|"`
Alternative regex: `"s|^/home/user\(/.*\)\?$|~\1|"`

`tilde=\~${PWD#~}`

[Source](https://unix.stackexchange.com/questions/207210/make-pwd-result-in-terms-of)

3. Print base file name using find

`find . -type f -name \*.out -exec basename {} ';'`

`find . -type f -name '*.out' | sed -e 's#.*/##'`

`find . -type f -name '*.out' -exec basename -a -- {} +`

`find . -type f -name \*.out -exec basename {} \;`

`find . -type f -name \*.out -printf '%f\n'`

[Source](https://unix.stackexchange.com/questions/169178/how-to-print-the-base-file-name-using-find-in-unix)
