return {
  "smjonas/inc-rename.nvim",
  opts = {},
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("")
      end,
      expr = true,
      desc = "IncRename Variable",
    },
  },
}
