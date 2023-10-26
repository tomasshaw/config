---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>mp"] = { ":MarkdownPreviewToggle <CR>", "Toggle Markdown Preview" },
  },
}

-- more keybinds!

return M
