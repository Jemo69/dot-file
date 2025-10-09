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
  })
})