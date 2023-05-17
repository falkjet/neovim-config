local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function copy(args)
    return args[1]
end

ls.add_snippets("tex", {
    s("env", {
        t "\\begin{",
        i(1),
        t { "}", "  " },
        i(0),
        t { "", "\\end{" },
        f(copy, 1),
        t "}"
    }),
    s("doc", {
        t "\\documentclass{", i(1, "article"),
        t { "}", "", "\\title{" }, i(2, "Title"),
        t { "}", "\\author{" }, i(3, "Author"),
        t { "}", "\\date{\\today}", "", "\\begin{document}", "  " },
        t { "\\maketitle", "", "  " },
        i(4),
        t { "", "\\end{document}" }

    })
}, {
    key = "tex",
})
