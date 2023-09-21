---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.markdown = {
  plugin = true,
  n = {
    ["<leader>mp"] = { ":MarkdownPreviewToggle", "Toggle Markdown Preview" },
  },
}
-- more keybinds!

return M
