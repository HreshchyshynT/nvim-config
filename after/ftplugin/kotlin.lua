local set = vim.opt_local

set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4

-- Sign for suspend functions
vim.fn.sign_define("suspend_fn", { text = "~", texthl = "DiagnosticInfo" })

local function mark_suspend_functions(bufnr)
  vim.fn.sign_unplace("suspend_signs", { buffer = bufnr })

  local parser = vim.treesitter.get_parser(bufnr, "kotlin")
  if not parser then
    return
  end

  local tree = parser:parse()[1]
  if not tree then
    return
  end

  local query = vim.treesitter.query.parse(
    "kotlin",
    [[
      (function_declaration
        (modifiers
          (function_modifier) @mod (#eq? @mod "suspend")))
    ]]
  )

  for _, node in query:iter_captures(tree:root(), bufnr) do
    local start_row = node:range()
    vim.fn.sign_place(0, "suspend_signs", "suspend_fn", bufnr, { lnum = start_row + 1 })
  end
end

-- Sign for suspend call sites (detected via LSP semantic tokens)
vim.fn.sign_define("suspend_call", { text = "~>", texthl = "DiagnosticInfo" })

local function mark_suspend_calls(bufnr)
  vim.fn.sign_unplace("suspend_call_signs", { buffer = bufnr })

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local marked_lines = {}

  for line = 0, line_count - 1 do
    local line_text = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1] or ""
    local first_char = line_text:find("%S") or 1
    local line_tokens = vim.lsp.semantic_tokens.get_at_pos(bufnr, line, first_char - 1) or {}
    for _, token in ipairs(line_tokens) do
      if token.type == "function" and token.modifiers and token.modifiers.async and not marked_lines[line] then
        marked_lines[line] = true
        vim.fn.sign_place(0, "suspend_call_signs", "suspend_call", bufnr, { lnum = line + 1 })
      end
    end
  end
end

local bufnr = vim.api.nvim_get_current_buf()
mark_suspend_functions(bufnr)

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
  buffer = bufnr,
  callback = function()
    mark_suspend_functions(bufnr)
  end,
})

vim.api.nvim_create_autocmd("LspTokenUpdate", {
  buffer = bufnr,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "kotlin_lsp" then
      mark_suspend_calls(args.buf)
    end
  end,
})
