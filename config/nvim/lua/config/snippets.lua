local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("c", {
  s(
    { trig = "stdio", priority = 1000 },
    {
      t({
        "#include <stdio.h>",
        "",
        "",
      }),
      i(1),
    }
  ),
  s(
      { trig = "cm", priority = 1000 },
      {
        t({
          "int main(void)",
          "{",
          "  ",
        }),
        i(1),
        t({
          "",
          "}",
        }),
      }
    ),
})
