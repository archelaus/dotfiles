### [Fish Shell](https://fishshell.com/) FAQ

---

1. How to assign value if variable is unset?

`set -q XYZ; or set XYZ whatever`

`set -q XYZ[1]; or set XYZ whatever`

`set -q XYZ || set XYZ stuff`

- Checks that the variable is not empty
`string length --quiet $var`

- Checks that the variable is empty
`not string length --quiet $var`

```
string length -q -- $XYZ; or set XYZ whatever
# or
test -n "$XYZ"; or set XYZ whatever
```

[Source #1](https://github.com/fish-shell/fish-shell/issues/3926)
[Source #2](https://stackoverflow.com/questions/47743015/fish-shell-how-to-check-if-a-variable-is-set-empty)

2. Pretty print fish_user_paths

`echo $fish_user_paths | tr " " "\n" | nl`

[Source #1](https://github.com/fish-shell/fish-shell/issues/2681)
