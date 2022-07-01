using OJSDefine
using Documenter

DocMeta.setdocmeta!(OJSDefine, :DocTestSetup, :(using OJSDefine); recursive=true)

makedocs(;
    modules=[OJSDefine],
    authors="Philipp Gewessler",
    repo="https://github.com/p-gw/OJSDefine.jl/blob/{commit}{path}#{line}",
    sitename="OJSDefine.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://p-gw.github.io/OJSDefine.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/p-gw/OJSDefine.jl",
    devbranch="main",
)
