require('lualine').setup{
  options = {
  	theme = 'molokai',
	icons_enabled = true,
	section_separators = {'', ''},
  	component_separators = {'', ''}
  },
  sections = {
    lualine_a = {{'filename', path = 3}},
    lualine_c = {'hostname'}
  }
}
