return {
  -- Core DAP engine
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- Signs
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticInfo' })

      -- Keymaps
      local map = vim.keymap.set
      map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
      map('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Condition: ')
      end, { desc = 'Debug: Conditional breakpoint' })

      map('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      map('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      map('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      map('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })

      map('n', '<leader>dr', dap.repl.open, { desc = 'Debug: REPL' })
      map('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
      map('n', '<leader>du', function()
        require('dapui').toggle()
      end, { desc = 'Debug: Toggle UI' })

      -- which-key group label
      pcall(function()
        require('which-key').add { { '<leader>d', group = '[D]ebug' } }
      end)

      -----------------------------------------------------------------------
      -- 🔹 LANGUAGE CONFIGURATIONS
      -----------------------------------------------------------------------
      -- PATH HELPERS
      local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'

      -- PYTHON -------------------------------------------------------------
      local py_path = mason_path .. '/debugpy/venv/bin/python'
      dap.adapters.python = {
        type = 'executable',
        command = py_path,
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch current file',
          program = '${file}',
          console = 'integratedTerminal',
          pythonPath = function()
            if vim.fn.executable './.venv/bin/python' == 1 then
              return './.venv/bin/python'
            elseif vim.fn.executable 'python' == 1 then
              return 'python'
            else
              return py_path
            end
          end,
        },
      }

      -- JAVASCRIPT / TYPESCRIPT -------------------------------------------
      local js_path = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter'
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = '127.0.0.1',
        port = '${port}',
        executable = {
          command = js_path,
          args = { '${port}' },
        },
      }
      dap.configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch current file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**' },
        },
      }
      dap.configurations.typescript = dap.configurations.javascript

      -- GO -----------------------------------------------------------------
      local dlv = (vim.fn.executable 'dlv' == 1) and 'dlv' or (vim.fn.stdpath 'data' .. '/mason/bin/dlv')
      dap.adapters.go = function(callback, _)
        callback {
          type = 'server',
          host = '127.0.0.1',
          port = '${port}',
          executable = {
            command = dlv,
            args = { 'dap', '-l', '127.0.0.1:${port}' },
          },
        }
      end
      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug file',
          request = 'launch',
          program = '${file}',
        },
        {
          type = 'go',
          name = 'Debug package',
          request = 'launch',
          program = '${workspaceFolder}',
        },
      }

      -- C / C++ / Rust -----------------------------------------------------
      local codelldb = mason_path .. '/codelldb/extension/adapter/codelldb'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb,
          args = { '--port', '${port}' },
        },
      }
      dap.configurations.cpp = {
        {
          name = 'Launch executable',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },

  -- UI
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  -- Inline virtual text
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = { virt_text_pos = 'eol', commented = true },
  },

  -- Mason integration for adapters
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    opts = {
      ensure_installed = { 'debugpy', 'js', 'delve', 'codelldb' },
      automatic_installation = true,
      handlers = {},
    },
  },
}
