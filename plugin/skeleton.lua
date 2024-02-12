vim.filetype.add({
  pattern = {
    ['.clang-format'] = 'clang-format',
  }
})

vim.api.nvim_create_user_command("TemplateInit", function(opts)
	local filetype = vim.filetype.match({ buf = 0 })

	require("skeleton").runOnCurrentBuffer(filetype)
end, {})

vim.api.nvim_create_user_command("TemplateEdit", function(opts)
	local filetype = vim.filetype.match({ buf = 0 })
	require("skeleton").templateEdit(filetype)
end, {})
