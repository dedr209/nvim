return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },

      signcolumn = true,   -- show signs in the sign column
      numhl      = false,  -- highlight line numbers (optional, can be noisy)
      linehl     = false,  -- highlight entire lines (optional, can be noisy)
      word_diff  = false,  -- inline word-level diff (cool but distracting)

      watch_gitdir = {
        follow_files = true  -- follow file moves/renames
      },

      attach_to_untracked = true,
      current_line_blame  = false, -- set true if you want blame on every line always

      current_line_blame_opts = {
        virt_text         = true,
        virt_text_pos     = "eol",  -- end of line
        delay             = 800,    -- ms before blame appears
        ignore_whitespace = false,
      },

      sign_priority        = 6,
      update_debounce      = 100,
      status_formatter     = nil,
      max_file_length      = 40000, -- disable for very large files
      preview_config = {
        border   = "rounded",
        style    = "minimal",
        relative = "cursor",
        row      = 0,
        col      = 1,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, "Next hunk")

        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, "Prev hunk")

        -- Staging
        map("n", "<leader>hs", gs.stage_hunk,  "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,  "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage entire buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset entire buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

        -- Visual mode staging (only selected lines)
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected lines")

        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected lines")

        -- Inspection
        map("n", "<leader>hp", gs.preview_hunk,        "Preview hunk")
        map("n", "<leader>hb", gs.blame_line,           "Blame current line")
        map("n", "<leader>hd", gs.diffthis,             "Diff this file")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against last commit")

        -- Toggle options on the fly
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
        map("n", "<leader>td", gs.toggle_deleted,             "Toggle deleted lines")
        map("n", "<leader>tw", gs.toggle_word_diff,           "Toggle word diff")

        -- Text objects — select a hunk like a motion
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", "Select hunk (text object)")
      end,
    })
  end,
}
