return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- The UI for the debugger
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
    -- Automatically installs debuggers via Mason
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      -- Installs the chrome and node debuggers automatically
      ensure_installed = { "js", "node2" },
      handlers = {},
    })

    -- 1. UI Auto-open/close
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- 2. Keymaps for Debugging
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })

    -- 3. Node.js specific config
    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File (Node)",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
    -- Reuse for TypeScript
    dap.configurations.typescript = dap.configurations.javascript
  end,
}