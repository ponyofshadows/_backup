-- ccls for C , C++ and Objctive-C
require'lspconfig'.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-Wno-everything"} ;
    };
  }
}
-- cmake-language-server
require'lspconfig'.cmake.setup{}

-- jedi-language-server for python
require'lspconfig'.jedi_language_server.setup{}

-- rust-analyzer for rust
require'lspconfig'.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- fortls for Fortran --installed py "yay -S fortls"
require'lspconfig'.fortls.setup{}

