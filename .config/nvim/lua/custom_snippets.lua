-- custom_snippets.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
    s("dmodel", {
        t("class "),
        i(1, "ModelName"),
        t("(models.Model):"),
        t({ "", "\t" }),
        i(2, "pass"),
        t({ "", "" })
    }),
})
ls.add_snippets("python", {

    s("py_func", {
        t("def "),
        i(1, "func_name"),
        t("("),
        i(2, ""),
        t("):"),
        t({ "", "\t" }),
        i(3, "pass"),
        t({ "", "" })
    })
})
ls.add_snippets("typescriptreact", {
    s("tanstack-component", {
        t("const"),
        i(1, "  componentName"),
        i(1, "= () => {"),
        t({ "", "\t" }),
        i(2, "return"),
        t({ "", "\t" }),
        i(3, "<div>"),
        t({ "", "\t" }),
        i(4, "</div>"),
        t({ "", "\t" }),
        i(5, "}"),
        t({ "", "" })

    })
})
