-- npm i -g pyright
require'lspconfig'.pyright.setup{

--  Commands:
--  - PyrightOrganizeImports: Organize Imports
  
--  Default Values:
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
--    venvPath = '.${workspaceRoot}/.venv/',
--    typingsPath = '${workspaceRoot}/typestubs',
    executionEnvironments = {
--        root = './',
--        venv = './',
--        extraPaths = { '/src' }
    },
--    root_dir = function(filename)
--          return util.root_pattern(unpack(root_files))(filename) or
--                 util.path.dirname(filename)
--        end;
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
--          extraPaths = { 'src', '/src' }
        }
      }
    }
}
