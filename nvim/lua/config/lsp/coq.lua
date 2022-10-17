vim.g.coq_settings = { 
	keymap = {
		recommended = false,
		jump_to_mark = '<C-\\>'
	},
	auto_start = true
}

-- Unmap default binding
vim.g.coq_settings = {
    ['keymap.jump_to_mark'] = null
}
