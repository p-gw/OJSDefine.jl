# OJSDefine

[![Build Status](https://github.com/p-gw/OJSDefine.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/p-gw/OJSDefine.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/p-gw/OJSDefine.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/p-gw/OJSDefine.jl)

**Note!** This functionality is now implemented in quarto. 

This Julia package provides a single function `ojs_define` to share data from a `julia` cell with an `ojs` cell in a [Quarto](https://quarto.org/) notebook. 

Within a notebook load the package and provide data to an ojs cell using keyword arguments. The name of the argument will be the variable name.

````
```{julia}
using OJSDefine

ojs_define(a="some string data")
```

```{ojs}
a
```
"some string data"
````

## Supported data types
`OJSDefine.jl` supports all data types that can be parsed to json via `JSON3`. In addition all data types implementing the `Tables.jl` interface (such as DataFrames) are supported.

````
```{julia}
using OJSDefine, DataFrames

df = DataFrame(a=randn(100), b=randn(100))
ojs_define(data=df)
```

```{ojs}
Plot.plot({
    grid: true,
    marks: [
        Plot.dot(df, {
            x: "a",
            y: "b"
        })
    ]
})
```
````


