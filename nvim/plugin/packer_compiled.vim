" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/amari/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/amari/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/amari/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/amari/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/amari/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ncm2 = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/ncm2"
  },
  ["ncm2-vim-lsp"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/ncm2-vim-lsp"
  },
  neogit = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-remote-containers"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-remote-containers"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-yarp"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/nvim-yarp"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ripgrep = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/ripgrep"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  sonokai = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/sonokai"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-lsp"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/vim-lsp"
  },
  ["vim-lsp-settings"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/vim-lsp-settings"
  },
  vimwiki = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/amari/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
