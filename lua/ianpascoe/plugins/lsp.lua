return {
  -- LSP Plugins
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {},
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = '[M]ason' },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    build = ':MasonToolsUpdate',
    cmd = { 'MasonToolsInstall', 'MasonToolsInstallSync', 'MasonToolsUpdate', 'MasonToolsUpdateSync', 'MasonToolsClean' },
    dependencies = { 'mason-org/mason.nvim' },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      -- Add LSP servers to ensure_installed that are set up in nvim-lspconfig and managed by mason-lspconfig
      opts.ensure_installed = opts.ensure_installed or {}
      local lspPlugin = require('lazy.core.config').spec.plugins['neovim/nvim-lspconfig']
      if lspPlugin then
        local Plugin = require 'lazy.core.plugin'
        local lspPluginOpts = Plugin.values(lspPlugin, 'opts', false)
        if lspPluginOpts and lspPluginOpts.servers then
          local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package)
          for server, server_opts in pairs(lspPluginOpts.servers) do
            if server_opts then
              server_opts = server_opts == true and {} or server_opts
              if server_opts.enabled ~= false and server_opts.mason ~= false and vim.tbl_contains(all_mslp_servers, server) then
                opts.ensure_installed[#opts.ensure_installed + 1] = server
              end
            end
          end
        end
      end

      Util.info('Ensuring mason tools are installed: ' .. table.concat(opts.ensure_installed, ', '),
        { title = 'Mason Tools' })
      require('mason-tool-installer').setup(opts)
      vim.cmd.MasonToolsUpdate()

      vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('mason_tool_installer', { clear = true }),
        pattern = 'MasonToolsUpdateCompleted',
        callback = function()
          vim.defer_fn(function()
            -- trigger FileType event to possibly load this newly installed LSP server
            require('lazy.core.handler.event').trigger {
              event = 'FileType',
              buf = vim.api.nvim_get_current_buf(),
            }
          end, 100)
        end,
      })
    end,
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = 'LazyFile',
    dependencies = {
      'mason-org/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'mason-org/mason-lspconfig.nvim', config = function() end },
      {
        'j-hui/fidget.nvim',
        opts = { notification = { window = { winblend = 0 } } },
      },
      'saghen/blink.cmp',
    },
    opts = {
      servers = {},
      setup = {},
      capabilities = {},
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
        callback = function(event)
          local map = function(mode, keys, func, desc)
            Util.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('n', 'grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')
          map('n', 'grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('n', 'gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('n', 'grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('n', 'grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('n', 'gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('n', 'gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('n', 'grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp_detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp_highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('n', 'gh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local servers = opts.servers or {}
      local capabilities = vim.tbl_deep_extend('force', {}, require('blink.cmp').get_lsp_capabilities(),
        opts.capabilities or {})

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] == true and {} or servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      local ensure_installed = {}
      local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package)
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            local is_mason_available = vim.tbl_contains(all_mslp_servers, server)
            if server_opts.mason == false or not is_mason_available then
              -- Not managed by mason (explicitly disabled or unsupported) -> setup immediately
              setup(server)
            else
              -- Managed by mason -> ensure installation and let mason-lspconfig call handler
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      -- Get existing ensure_installed from mason-tool-installer plugin
      local mtiPlugin = require('lazy.core.config').spec.plugins['WhoIsSethDaniel/mason-tool-installer.nvim']
      if mtiPlugin then
        local Plugin = require 'lazy.core.plugin'
        local mtiPluginOpts = Plugin.values(mtiPlugin, 'opts', false)
        vim.list_extend(ensure_installed, mtiPluginOpts.ensure_installed or {})
      end

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }
      vim.cmd.MasonToolsUpdate()

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- handled in mason-tool-installer
        handlers = { setup },
      }
    end,
  },
  { import = 'ianpascoe.plugins.lang' },
}
