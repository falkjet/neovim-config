local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("zig", {
    s("println", {
        t 'print("', i(1), t '\\n", .{ ', i(2), t { ' });', '' },
    }),
}, {
    key = "zig",
})
