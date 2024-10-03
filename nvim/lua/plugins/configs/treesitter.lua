local function is_big_file()
  local full_buf_path = vim.api.nvim_buf_get_name(0);
  local stat = vim.loop.fs_stat(full_buf_path)
  if stat then
    local filesize_kb = stat.size / 1024;
    if filesize_kb > 1000 then
      return true
    end
    return false
  else
    return false
  end
end

local options = {
  auto_install = true,
  ensure_installed = {
    "lua",
    "tsx",
    "javascript",
    "typescript",
    "css",
    "html",
    "python",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function()
      return is_big_file()
    end,
  },

  indent = { enable = true },
  additional_vim_regex_highlighting = false,

  require('ts_context_commentstring').setup {
    enable_autocmd = false,
    languages = {
      typescript = '// %s',
    },
  }

}

return options
