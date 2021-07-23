require('lualine').setup{
  options = {
  	theme = 'molokai',
	icons_enabled = true,
	section_separators = {'', ''},
  	component_separators = {'', ''}
  },
  sections = {
    lualine_c = {'filename', 'hostname'}
  }
}
