### [Fish Shell](https://fishshell.com/) Tips and Tricks

---

- How to assign value if variable is unset?

`set -q XYZ; or set XYZ whatever`

`set -q XYZ[1]; or set XYZ whatever`

```
string length -q -- $XYZ; or set XYZ whatever
# or
test -n "$XYZ"; or set XYZ whatever
```

`set -q XYZ || set XYZ stuff`

`string length --quiet $var` # checks that the variable is not empty

`not string length --quiet $var` # checks that the variable is empty
