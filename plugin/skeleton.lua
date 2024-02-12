vim.api.nvim_create_user_command("TemplateInit", function(opts)
	-- local filetype = vim.filetype.match({ buf = 0 })
        local filename = vim.api.nvim_buf_get_name(0)
	local extension = vim.fn.fnamemodify(filename, ":e")
	if extension == nil or extension == "" then
	    extension = vim.fn.fnamemodify(filename, ":t:r")
	end
	require("skeleton").runOnCurrentBuffer(extension)
end, {})

vim.api.nvim_create_user_command("TemplateEdit", function(opts)
	-- local filetype = vim.filetype.match({ buf = 0 })
	local filename = vim.api.nvim_buf_get_name(0)
	local extension = vim.fn.fnamemodify(filename, ":e")
	if extension == nil or extension == "" then
	    extension = vim.fn.fnamemodify(filename, ":t:r")
	end
	require("skeleton").templateEdit(extension)
end, {})
