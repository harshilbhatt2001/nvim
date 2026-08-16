local plugins = {}

-- Under the nix wrapper the config is dofile'd from the store, which is not
-- stdpath("config"); CONFIG_ROOT (set in flake.nix) points at it. Without the
-- wrapper (this repo checked out as ~/.config/nvim) fall back to stdpath.
local config_root = os.getenv("CONFIG_ROOT") or vim.fn.stdpath("config")
local lua_path = config_root .. "/lua"
local plugin_dir = lua_path .. "/plugins"

-- Search recursively for all .lua files under lua/plugins/
local files = vim.fn.split(vim.fn.globpath(plugin_dir, "**/*.lua"), "\n")

for _, file in ipairs(files) do
	-- Get path relative to the 'lua' directory and turn it into a module
	-- path: plugins/ui/colourscheme.lua -> plugins.ui.colourscheme
	local relative_path = file:sub(#lua_path + 2)
	local module_path = relative_path:gsub("%.lua$", ""):gsub("/", ".")

	-- Don't require the current file (plugins.init)
	if not module_path:match("%.init$") and module_path ~= "plugins" then
		local status_ok, module_content = pcall(require, module_path)

		if status_ok then
			table.insert(plugins, module_content)
		else
			vim.notify("Error loading " .. module_path .. ": " .. module_content, vim.log.levels.ERROR)
		end
	end
end

return plugins
