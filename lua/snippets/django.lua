local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("htmldjango", {
    s("block", {
        t '{% block ', i(1), t { ' %}', '    ' }, i(0), t { '', '{% endblock %}' }
    }),
    s("extends", {
        t '{% extends \'', i(1), t { '\' %}', '' }
    }),
}, {
    key = "django",
})
