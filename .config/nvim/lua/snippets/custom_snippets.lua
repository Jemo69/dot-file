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
    t({"", "\t"}),
    i(2, "pass"),
    t({"", ""})
  }),
  s("def", {
    t("def "),
    i(1, "function_name"),
    t("("),
    i(2, "params"),
    t("):"),
    t({"", "\t"}),
    i(3, "pass"),
    t({"", ""})
  })
})