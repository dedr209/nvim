return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- Detection methods: looks for .git, go.mod, package.json, etc.
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod" },
    })
  end,
}
