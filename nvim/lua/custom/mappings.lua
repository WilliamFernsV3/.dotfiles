local M = {}

M.navigation = {
  n = {
    ['C-h'] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ['C-l'] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ['C-j'] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ['C-k'] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
  }
}

M.formatting = {
  n = {
    ["<leader>fpf"] = {
      function()
        local current_file = vim.api.nvim_buf_get_name(0)
        if string.match(current_file, "%.py$") then
          vim.cmd("!black -l 79 " .. current_file)
        else
          print("Not a Python file!")
        end
      end,
      "Format current Python file",
    },
    ["<leader>fpd"] = {
      function()
        local current_dirend = vim.fn.expand("%:p:h")
        -- Call black on the directory
        vim.cmd("!black -l 79 " .. current_dirend)
      end,
      "Format current Python directory",
    },
  },
}

M.harpoon = {
  n = {
    ["<leader>a"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "Mark file"
    },
    ["<C-e>"] = {
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      "Toggle UI"
    },
    ["<leader>1"] = {
      function()
        require('harpoon.ui').nav_file(1)
      end,
      "Go to file 1"
    },
    ["<leader>2"] = {
      function()
        require('harpoon.ui').nav_file(2)
      end,
      "Go to file 2"
    },
    ["<leader>3"] = {
      function()
        require('harpoon.ui').nav_file(3)
      end,
      "Go to file 3"
    },
    ["<leader>4"] = {
      function()
        require('harpoon.ui').nav_file(4)
      end,
      "Go to file 4"
    },
  }
}

M.splits = {
  n = {
    ["<leader>%"] = {
      " <cmd> vsp<CR>", "Split vertically",
    },
    ['<leader>"'] = {
      " <cmd> sp<CR>", "Split horizontally",
    }
  }
}

M.windows = {
  n = {
    ["<leader>w="] = {
      " <cmd> wincmd =<CR>", "Windows Equal",
    },
    ['<leader>wf'] = {
      function()
        vim.cmd("wincmd _")
        vim.cmd("wincmd |")
      end,
      "Window Full",
    }
  }
}

M.glow = {
  n = {
    ["<leader>mp"] = {
      function()
        local filename = string.gsub(vim.fn.expand("%"), " ", "\\ ")
        local command = "Glow " .. filename
        print("Running command: " .. command)
        vim.cmd(command)
      end,
      "Glow Preview Current Markdown File"
    },
  }
}

M.wrap_lines = {
  n = {
    ["<leader>tw"] = {
      function()
        -- ignore lua_ls "undefined field "get""
        -- @diagnostic disable-next-line
        local is_wrap = vim.opt.wrap:get()
        if is_wrap then
          vim.opt.wrap = false
        else
          vim.opt.wrap = true
        end
      end,
      "Toggle Line Wrap",
    },
    ["<leader>wtw"] = {
      function()
        -- ignore linting "undefined field get"
        -- @diagnostic disable-next-line
        local is_wrap = vim.opt.wrap:get()
        if is_wrap then
          -- set wrapping to false for all windows
          vim.cmd("windo set nowrap")
        else
          vim.cmd("windo set wrap")
        end
      end,
      "Toggle Line Wrap All Windows",
    },
  }
}

return M
