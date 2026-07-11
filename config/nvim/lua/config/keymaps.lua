vim.keymap.del("i", "<Tab>")
vim.keymap.del("s", "<Tab>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "USE h TO MOVE"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "USE l TO MOVE"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "USE k TO MOVE"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "USE j TO MOVE"<CR>')

vim.keymap.set("n", "<S-Tab>", ":bnext<CR>", { desc = "Next buffer" })

---------- RUN PYTHON FILE ---------- 
vim.keymap.set("n", "<leader>p", function()
	vim.cmd("write")
	local file = vim.fn.expand("%")
	vim.cmd("split | terminal python3 " .. file)
end, { desc = "Run Python file" })

---------- SURROUND LIST WITH "" CMD ---------- 
-- Mark your list with 'vi{' and <leader>' to add "" to the items inside
-- Example: 
-- if you have a: list = { a, b, c }
-- use vi{ to select everything inside the {}
-- then <leader> + '
-- it will return: list = { "a", "b", "c" }
vim.keymap.set("v", "<leader>'", function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line-1, end_line, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("{(.-)}", function(content)
      local elems = {}
      for item in content:gmatch("[^,]+") do
        item = item:match("^%s*(.-)%s*$")
        if not (item:match('^".*"$')) then
          item = '"' .. item .. '"'
        end
        table.insert(elems, item)
      end
      return "{" .. table.concat(elems, ", ") .. "}"
    end)
  end

  vim.api.nvim_buf_set_lines(0, start_line-1, end_line, false, lines)
end, { silent = true, desc = 'Surround list with quotes safely' })

---------- START TELESCOPE CMDS ----------
-- CMD TO SEARCH INSIDE .CONFIG FOLDER
vim.keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.expand("~/.config"),
		hidden = true,
	})
end, { desc = "Find in .config" })
---------- END TELESCOPE CMDS ----------

---------- START MINI-SURROUND CMDS ----------
vim.keymap.set("n", "sw", 'saiw"', { desc = "Surround word with quotes", remap = true })
---------- END MINI-SURROUND CMDS ----------
