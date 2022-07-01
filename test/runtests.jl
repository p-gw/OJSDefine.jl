using OJSDefine
using Test
using DataFrames
using CSV
using JSONTables
using Quarto

@testset "OJSDefine.jl" begin
    # script tag
    @test OJSDefine.script_tag("") == "<script type='ojs-define'></script>"
    @test OJSDefine.script_tag("content") == "<script type='ojs-define'>content</script>"

    # _convert
    @test OJSDefine._convert(1) == 1
    @test OJSDefine._convert(10.0) == 10.0
    @test OJSDefine._convert("abc") == "abc"

    df = DataFrame(a=1:10)
    @test OJSDefine._convert(df) isa JSONTables.ArrayTable
    @test length(OJSDefine._convert(df)) == 10

    csv = CSV.File(codeunits("""
    a,b
    1,"1"
    2,"2"
    3,"3"
    """))

    @test OJSDefine._convert(csv) isa JSONTables.ArrayTable
    @test length(OJSDefine._convert(csv)) == 3

    # _content_dict
    @test OJSDefine._content_dict() == Dict("contents" => [])
    @test OJSDefine._content_dict(a="1") == Dict("contents" => [
        Dict("name" => :a, "value" => "1")
    ])
    @test OJSDefine._content_dict(a="1", b=2) == Dict("contents" => [
        Dict("name" => :a, "value" => "1"),
        Dict("name" => :b, "value" => 2)
    ])
    @test OJSDefine._content_dict(arr=[1, 2, 3]) == Dict("contents" => [
        Dict("name" => :arr, "value" => [1, 2, 3])
    ])

    # check if quarto is installed
    if !isnothing(Quarto.path())
        Quarto.render("test.qmd", cache=false, kernel_restart=true)
    end
end
