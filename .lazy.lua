-- Project-local LazyVim configuration
-- This file is automatically loaded by LazyVim for project-specific settings

return {
	-- Configure snacks explorer to show hidden and gitignored files
	-- but exclude .git directory
	{
		"folke/snacks.nvim",
		opts = {
			explorer = {
				hidden = true,
				ignored = true,
				exclude = { ".git" }, -- Exclude .git directory
			},
			picker = {
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
						exclude = { ".git" }, -- Exclude .git directory
					},
				},
			},
		},
	},
}
