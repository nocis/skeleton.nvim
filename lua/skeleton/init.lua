local M = {}
function M.setup(options)
	vim.api.nvim_create_user_command("TemplateInit", function(opts)
		local bufname = vim.api.nvim_buf_get_name(0)
		local filetype = vim.filetype.match({ filename = bufname })

		vim.notify("not empty file" .. bufname .. filetype, vim.log.levels.INFO, {})
		require("skeleton").runOnCurrentBuffer(filetype)
	end, {})

	vim.api.nvim_create_user_command("TemplateEdit", function(opts)
		local bufname = vim.api.nvim_buf_get_name(0)
		local filetype = vim.filetype.match({ filename = bufname })
		require("skeleton").templateEdit(filetype)
	end, {})
end
return M
