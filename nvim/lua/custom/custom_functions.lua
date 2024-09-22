local M = {};

M.command_with_args = function(command)
  -- Prompt for user input
  local args = vim.fn.input("Arguments: ")
  -- Execute the command with the provided arguments
  vim.cmd(command .. " " .. args)
end

M.file_exists = function(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else return false end
end


M.get_ruff_config_path = function()
  local possible_ruff_config_file_names = { "ruff.toml", "pyproject.toml" }
  local cwd = vim.fn.getcwd()
  local config_path = nil

  for _, name in ipairs(possible_ruff_config_file_names) do
    curr_file_output_path = cwd .. "/" .. name
    if M.file_exists(curr_file_output_path) then
      config_path = curr_file_output_path
      break
    end
  end
  return config_path
end

return M
