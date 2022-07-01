module OJSDefine

using IJulia
using JSON3
using JSONTables
using Tables

export ojs_define

script_tag(x) = "<script type='ojs-define'>" * x * "</script>"

function _convert(x)
    if Tables.istable(x)
        return JSONTables.ArrayTable(Tables.rows(x))
    else
        return x
    end
end

function _content_dict(; kwargs...)
    content = Dict("contents" => [
        Dict("name" => k, "value" => _convert(v)) for (k, v) in kwargs
    ])
    return content
end

function ojs_define(; kwargs...)
    content = _content_dict(; kwargs...)
    json_str = JSON3.write(content)
    IJulia.display(MIME("text/html"), script_tag(json_str))
end

end
