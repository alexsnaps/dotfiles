local get_active_lsp = function()
  local msg = "🚫"
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    extensions = { 'lazy', 'mason', 'neo-tree', 'trouble' },
    sections = {
      lualine_x = {
        'encoding', 
        'fileformat', 
        {
          get_active_lsp,
          icon = "📡",
        },
        'filetype',
      },
    },
  },
}
