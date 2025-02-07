-- Nixvim's internal module table
-- Can be used to share code throughout init.lua
local _M = {}

-- Set up globals {{{
do
    local nixvim_globals = {
        localleader = "\\",
        mapleader = " ",
        matchup_surround_enabled = 1,
        matchup_transmute_enabled = 1,
        mkdp_auto_close = 0,
        mkdp_theme = "dark",
        undotree_CursorLine = true,
        undotree_DiffAutoOpen = true,
        undotree_DiffCommand = "diff",
        undotree_DiffpanelHeight = 10,
        undotree_HelpLine = true,
        undotree_HighlightChangedText = true,
        undotree_HighlightChangedWithSign = true,
        undotree_HighlightSyntaxAdd = "DiffAdd",
        undotree_HighlightSyntaxChange = "DiffChange",
        undotree_HighlightSyntaxDel = "DiffDelete",
        undotree_RelativeTimestamp = true,
        undotree_SetFocusWhenToggle = true,
        undotree_ShortIndicators = false,
        undotree_TreeNodeShape = "*",
        undotree_TreeReturnShape = "\\",
        undotree_TreeSplitShape = "/",
        undotree_TreeVertShape = "|",
    }

    for k, v in pairs(nixvim_globals) do
        vim.g[k] = v
    end
end
-- }}}

-- Set up options {{{
do
    local nixvim_options = {
        autoread = true,
        backup = false,
        breakindent = true,
        ch = 3,
        clipboard = "unnamedplus",
        cmdheight = 0,
        completeopt = { "menu", "menuone", "noselect" },
        copyindent = true,
        cursorcolumn = false,
        cursorline = true,
        diffopt = "internal,filler,closeoff,vertical,iwhite,hiddenoff",
        expandtab = true,
        fillchars = {
            diff = "╱",
            eob = " ",
            fold = " ",
            foldclose = "",
            foldopen = "",
            horiz = "━",
            horizdown = "┳",
            horizup = "┻",
            msgsep = "‾",
            vert = "┃",
            verthoriz = "╋",
            vertleft = "┫",
            vertright = "┣",
        },
        foldenable = true,
        foldexpr = "nvim_treesitter#foldexpr()",
        foldlevel = 99,
        foldlevelstart = -1,
        foldmethod = "expr",
        gdefault = true,
        hidden = true,
        history = 100,
        laststatus = 3,
        lazyredraw = false,
        list = true,
        listchars = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮",
        modeline = true,
        modelines = 100,
        mouse = "a",
        mousemodel = "extend",
        number = true,
        pumblend = 10,
        pumheight = 10,
        pumwidth = 20,
        relativenumber = true,
        scrolloff = 8,
        sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
        shiftround = true,
        shiftwidth = 4,
        shortmess = "filnxtToOFc",
        showbreak = "↪ ",
        showmatch = true,
        showmode = false,
        showtabline = 2,
        sidescroll = 5,
        sidescrolloff = 20,
        smartindent = true,
        smarttab = true,
        softtabstop = 4,
        spell = true,
        spelllang = "en_us",
        splitbelow = true,
        splitright = true,
        swapfile = false,
        synmaxcol = 240,
        tabstop = 4,
        termguicolors = true,
        textwidth = 120,
        title = true,
        wildmode = "list:longest,list:full",
        wrap = false,
        writebackup = false,
    }

    for k, v in pairs(nixvim_options) do
        vim.opt[k] = v
    end
end
-- }}}

require("lz.n").load({
    {
        "yazi.nvim",
        after = function()
            require("yazi").setup({})
        end,
        cmd = { "Yazi" },
    },
    {
        "yanky.nvim",
        after = function()
            do
                local utils = require("yanky.utils")
                local mapping = require("yanky.telescope.mapping")

                require("yanky").setup({
                    ring = {
                        cancel_event = "update",
                        history_length = 100,
                        ignore_registers = { "_" },
                        storage = "sqlite",
                        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
                        sync_with_numbered_registers = true,
                        update_register_on_cycle = false,
                    },
                })
            end
        end,
        keys = {
            { "<leader>fy", "<cmd>Telescope yank_history<cr>", desc = "Paste from yanky" },
            { "y", "<Plug>(YankyYank)", desc = "Yank text", mode = { "n", "x" } },
            { "p", "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor", mode = { "n", "x" } },
            { "P", "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor", mode = { "n", "x" } },
            { "gp", "<Plug>(YankyGPutAfter)", desc = "Put yanked text after selection", mode = { "n", "x" } },
            { "gP", "<Plug>(YankyGPutBefore)", desc = "Put yanked text before selection", mode = { "n", "x" } },
            { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
            { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
            { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
            { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
            { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
            { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
            { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
            { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
            { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
        },
    },
    {
        "which-key.nvim",
        after = function()
            require("which-key").setup({
                replace = {
                    desc = {
                        { "<space>", "SPACE" },
                        { "<leader>", "SPACE" },
                        { "<[cC][rR]>", "RETURN" },
                        { "<[tT][aA][bB]>", "TAB" },
                        { "<[bB][sS]>", "BACKSPACE" },
                    },
                },
                spec = {
                    { "<leader>b", group = "Buffers" },
                    { "<leader>bs", group = "󰒺 Sort", icon = "" },
                    { "<leader>g", group = "Git" },
                    { "<leader>f", group = "Find" },
                    { "<leader>r", group = "Refactor", icon = " " },
                    { "<leader>t", group = "Terminal" },
                    { "<leader>u", group = "UI/UX" },
                    { "<leader>r", group = "Refactor", icon = " ", mode = "x" },
                    { "<leader>u", group = "Trouble", icon = "", mode = "n" },
                    { "<leader>l", group = "LSP", icon = " " },
                    { "<leader>la", desc = "Code Action" },
                    { "<leader>ld", desc = "Definition" },
                    { "<leader>lD", desc = "References" },
                    { "<leader>lf", desc = "Format" },
                    { "<leader>l[", desc = "Prev" },
                    { "<leader>l]", desc = "Next" },
                    { "<leader>lt", desc = "Type Definition" },
                    { "<leader>li", desc = "Implementation" },
                    { "<leader>lh", desc = "Lsp Hover" },
                    { "<leader>lH", desc = "Diagnostic Hover" },
                    { "<leader>lr", desc = "Rename" },
                    { "<leader>v", group = "Vim training", icon = "󱛊", mode = "n" },
                    { "<leader>h", group = "Harpoon", icon = "󱡀 " },
                    { "<leader>ha", desc = "Add" },
                    { "<leader>he", desc = "QuickMenu" },
                    { "<leader>hj", desc = "1" },
                    { "<leader>hk", desc = "2" },
                    { "<leader>hl", desc = "3" },
                    { "<leader>hm", desc = "4" },
                    { "<leader>gW", group = "Worktree", icon = "󰙅 " },
                    { "<leader>lg", group = "Glance", icon = "󰍉" },
                    { "<leader>gh", group = "Hunks", icon = " " },
                    { "<leader>ug", group = "Git" },
                    { "<leader>c", group = "Codesnap", icon = "󰄄 ", mode = "v" },
                    { "<leader>C", group = "Comment-box", icon = " " },
                },
                win = { border = "single" },
            })
        end,
        event = "DeferredUIEnter",
    },
    {
        "toggleterm.nvim",
        after = function()
            require("toggleterm").setup({ direction = "float" })
        end,
        cmd = "ToggleTerm",
        keys = { "<leader>tg", "<leader>gg" },
    },
    {
        "todo-comments.nvim",
        after = function()
            require("todo-comments").setup({})
        end,
        event = { "BufEnter" },
    },
    {
        "telescope.nvim",
        after = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "^.git/",
                        "^.mypy_cache/",
                        "^__pycache__/",
                        "^output/",
                        "^data/",
                        "%.ipynb",
                    },
                    mappings = {
                        i = {
                            ["<c-s>"] = function(prompt_bufnr)
                                require("flash").jump({
                                    pattern = "^",
                                    label = { after = { 0, 0 } },
                                    search = {
                                        mode = "search",
                                        exclude = {
                                            function(win)
                                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                                                    ~= "TelescopeResults"
                                            end,
                                        },
                                    },
                                    action = function(match)
                                        local picker =
                                            require("telescope.actions.state").get_current_picker(prompt_bufnr)
                                        picker:set_selection(match.pos[1] - 1)
                                    end,
                                })
                            end,
                        },
                        n = {
                            s = function(prompt_bufnr)
                                require("flash").jump({
                                    pattern = "^",
                                    label = { after = { 0, 0 } },
                                    search = {
                                        mode = "search",
                                        exclude = {
                                            function(win)
                                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                                                    ~= "TelescopeResults"
                                            end,
                                        },
                                    },
                                    action = function(match)
                                        local picker =
                                            require("telescope.actions.state").get_current_picker(prompt_bufnr)
                                        picker:set_selection(match.pos[1] - 1)
                                    end,
                                })
                            end,
                        },
                    },
                    set_env = { COLORTERM = "truecolor" },
                },
                extensions = {
                    file_browser = { hidden = true },
                    ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                    undo = {
                        layout_config = { preview_height = 0.8 },
                        layout_strategy = "vertical",
                        side_by_side = true,
                    },
                },
                pickers = { colorscheme = { enable_preview = true } },
            })

            local __telescopeExtensions = {
                "undo",
                "ui-select",
                "manix",
                "live_grep_args",
                "fzf",
                "file_browser",
                "refactoring",
                "projects",
                "git_worktree",
            }
            for i, extension in ipairs(__telescopeExtensions) do
                require("telescope").load_extension(extension)
            end
        end,
        cmd = "Telescope",
    },
    {
        "statuscol.nvim",
        after = function()
            require("statuscol").setup({
                relculright = true,
                segments = {
                    { click = "v:lua.ScFa", hl = "FoldColumn", text = { require("statuscol.builtin").foldfunc } },
                    {
                        click = "v:lua.ScSa",
                        sign = { auto = true, maxwidth = 2, name = { ".*" }, namespace = { ".*" }, text = { ".*" } },
                    },
                    { click = "v:lua.ScLa", text = { " ", require("statuscol.builtin").lnumfunc, " " } },
                    {
                        click = "v:lua.ScSa",
                        sign = { auto = true, colwidth = 1, maxwidth = 2, name = { ".*" }, wrap = true },
                    },
                },
            })
        end,
        event = { "BufEnter" },
    },
    {
        "nvim-spectre",
        after = function()
            require("spectre").setup({})
        end,
        cmd = "Spectre",
    },
    {
        "smartcolumn.nvim",
        after = function()
            require("smartcolumn").setup({
                colorcolumn = "100",
                custom_colorcolumn = {
                    go = { "100", "130" },
                    java = { "100", "140" },
                    nix = { "100", "120" },
                    python = { "100", "120" },
                    rust = { "100", "120" },
                },
                disabled_filetypes = {
                    "ministarter",
                    "checkhealth",
                    "help",
                    "lspinfo",
                    "markdown",
                    "neo-tree",
                    "noice",
                    "text",
                },
                scope = "file",
            })
        end,
        event = "BufEnter",
    },
    {
        "refactoring.nvim",
        after = function()
            require("refactoring").setup({})
        end,
        cmd = "Refactor",
    },
    {
        "helpview.nvim",
        after = function()
            require("helpview").setup({ hybrid_modes = { "i", "r" }, mode = { "n", "x", "i", "r" } })
        end,
        ft = "help",
    },
    {
        "grug-far.nvim",
        after = function()
            require("grug-far").setup({})
        end,
        cmd = "GrugFar",
    },
    {
        "glance.nvim",
        after = function()
            require("glance").setup({ border = { enable = true } })
        end,
        cmd = "Glance",
    },
    {
        "CopilotChat.nvim",
        after = function()
            require("CopilotChat").setup({})
        end,
        cmd = "CopilotChat",
    },
    {
        "comment-box.nvim",
        after = function()
            require("comment-box").setup({})
        end,
        cmd = { "CBd", "CBccbox", "CBllline", "CBline" },
    },
    {
        "nvim-colorizer.lua",
        after = function()
            require("colorizer").setup({})
        end,
        cmd = "ColorizerToggle",
    },
    {
        "codesnap.nvim",
        after = function()
            require("codesnap").setup({
                breadcrumbs_separator = "/",
                code_font_family = "MonoLisa Nerd Font",
                has_breadcrumbs = true,
                has_line_number = false,
                mac_window_bar = true,
                save_path = "$XDG_PICTURES_DIR/screenshots",
                title = "CodeSnap.nvim",
                watermark = "",
            })
        end,
        cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
    },
    {
        "bufferline.nvim",
        after = function()
            require("bufferline").setup({
                options = {
                    always_show_bufferline = true,
                    buffer_close_icon = "󰅖",
                    close_command = function(bufnum)
                        require("mini.bufremove").delete(bufnum)
                    end,
                    close_icon = "",
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = ""
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or "")
                            if sym ~= "" then
                                s = s .. " " .. n .. sym
                            end
                        end
                        return s
                    end,
                    enforce_regular_tabs = false,
                    groups = {
                        items = {
                            {
                                highlight = { fg = "#a6da95", sp = "#494d64", underline = true },
                                matcher = function(buf)
                                    return buf.name:match("%test") or buf.name:match("%.spec")
                                end,
                                name = "Tests",
                                priority = 2,
                            },
                            {
                                auto_close = false,
                                highlight = { fg = "#ffffff", sp = "#494d64", undercurl = true },
                                matcher = function(buf)
                                    return buf.name:match("%.md") or buf.name:match("%.txt")
                                end,
                                name = "Docs",
                            },
                        },
                        options = { toggle_hidden_on_enter = true },
                    },
                    indicator = { icon = "▎", style = "icon" },
                    left_trunc_marker = "",
                    max_name_length = 18,
                    max_prefix_length = 15,
                    mode = "buffers",
                    modified_icon = "●",
                    numbers = function(opts)
                        return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
                    end,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            highlight = "Directory",
                            text = "File Explorer",
                            text_align = "center",
                        },
                    },
                    persist_buffer_sort = true,
                    right_mouse_command = "vertical sbuffer %d",
                    right_trunc_marker = "",
                    separator_style = "slant",
                    show_buffer_close_icons = true,
                    show_buffer_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    sort_by = "extension",
                    tab_size = 18,
                },
            })
        end,
        event = "BufEnter",
    },
})

require("catppuccin").setup({ flavour = "mocha" })

vim.diagnostic.config({ virtual_text = false })

vim.cmd([[let $BAT_THEME = 'Catppuccin Macchiato'

colorscheme catppuccin
]])
require("nvim-web-devicons").setup({})

require("mini.ai").setup({})

require("mini.align").setup({})

require("mini.bufremove").setup({})

require("mini.icons").setup({})

require("mini.map").setup({
    integrations = {
        require("mini.map").gen_integration.builtin_search(),
        require("mini.map").gen_integration.gitsigns(),
        require("mini.map").gen_integration.diagnostic(),
    },
    window = { winblend = 0 },
})

require("mini.snippets").setup({
    snippets = {
        require("mini.snippets").gen_loader.from_file(
            "/nix/store/78n67lsymjbi7yzajhg08aks2n5ivymm-vimplugin-friendly-snippets-2024-12-02/snippets/global.json"
        ),
        require("mini.snippets").gen_loader.from_lang(),
    },
})
MiniIcons.mock_nvim_web_devicons()

-- LSP {{{
do
    local __lspServers = {
        { name = "zk" },
        { name = "yamlls" },
        { extraOptions = { init_options = { diagnosticSeverity = "Hint" } }, name = "typos_lsp" },
        { extraOptions = { cmd = { "statix", "check", "-s" } }, name = "statix" },
        { name = "sqls" },
        { name = "ruff" },
        {
            extraOptions = {
                settings = {
                    pylsp = {
                        configurationSources = { "flake8" },
                        plugins = {
                            black = { cache_config = true, enabled = true, line_length = 120, preview = true },
                            flake8 = { enabled = true, indentSize = 4, maxLineLength = 120 },
                            isort = { enabled = true },
                            jedi_completion = {
                                cache_for = { "pandas", "numpy", "tensorflow", "matplotlib", "instaloader" },
                                enabled = true,
                            },
                            mccabe = { enabled = false },
                            memestra = { enabled = false },
                            preload = { enabled = true },
                            pycodestyle = { enabled = false, maxLineLength = 120 },
                            pydocstyle = { convention = "numpy", enabled = true },
                            pyflakes = { enabled = false },
                            pylint = { enabled = false },
                            pylsp_mypy = { enabled = true, overrides = { "--ignore-missing-imports", true } },
                            rope = { enabled = true },
                            yapf = { enabled = false },
                        },
                    },
                },
            },
            name = "pylsp",
        },
        {
            extraOptions = {
                settings = {
                    ["nil"] = {
                        formatting = {
                            command = {
                                "/nix/store/5437izm22g3084vsh0jmqmazgrdgib5n-nixfmt-unstable-2024-12-04/bin/nixfmt",
                            },
                        },
                        nix = { flake = { autoArchive = true } },
                    },
                },
            },
            name = "nil_ls",
        },
        { name = "marksman" },
        { name = "lua_ls" },
        { name = "jsonls" },
        {
            extraOptions = {
                settings = {
                    ["harper-ls"] = {
                        codeActions = { forceStable = true },
                        linters = {
                            boring_words = true,
                            linking_verbs = true,
                            sentence_capitalization = false,
                            spell_check = false,
                        },
                    },
                },
            },
            name = "harper_ls",
        },
        { name = "dockerls" },
        { name = "bashls" },
    }
    -- Adding lspOnAttach function to nixvim module lua table so other plugins can hook into it.
    _M.lspOnAttach = function(client, bufnr)
        -- LSP Inlay Hints {{{
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        -- }}}
    end
    local __lspCapabilities = function()
        capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

        return capabilities
    end

    local __setup = {
        on_attach = _M.lspOnAttach,
        capabilities = __lspCapabilities(),
    }

    for i, server in ipairs(__lspServers) do
        if type(server) == "string" then
            require("lspconfig")[server].setup(__setup)
        else
            local options = server.extraOptions

            if options == nil then
                options = __setup
            else
                options = vim.tbl_extend("keep", options, __setup)
            end

            require("lspconfig")[server.name].setup(options)
        end
    end
end
-- }}}

require("zk").setup({
    lsp = {
        auto_attach = { enabled = true, filetypes = { "markdown" } },
        config = { cmd = { "zk", "lsp" }, name = "zk" },
    },
    picker = "telescope",
})

require("ts-comments").setup({
    lang = {
        astro = "<!-- %s -->",
        axaml = "<!-- %s -->",
        blueprint = "// %s",
        c = "// %s",
        c_sharp = "// %s",
        clojure = { ";; %s", "; %s" },
        cpp = "// %s",
        cs_project = "<!-- %s -->",
        cue = "// %s",
        fsharp = "// %s",
        fsharp_project = "<!-- %s -->",
        gleam = "// %s",
        glimmer = "{{! %s }}",
        graphql = "# %s",
        handlebars = "{{! %s }}",
        hcl = "# %s",
        html = "<!-- %s -->",
        hyprlang = "# %s",
        ini = "; %s",
        ipynb = "# %s",
        javascript = {
            "// %s",
            "/* %s */",
            call_expression = "// %s",
            jsx_attribute = "// %s",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            spread_element = "// %s",
            statement_block = "// %s",
        },
        nix = "# %s",
        nu = "# %s",
        php = "// %s",
        rego = "# %s",
        rescript = "// %s",
        rust = { "// %s", "/* %s */" },
        sql = "-- %s",
        styled = "/* %s */",
        svelte = "<!-- %s -->",
        templ = { "// %s", component_block = "<!-- %s -->" },
        terraform = "# %s",
        tsx = {
            "// %s",
            "/* %s */",
            call_expression = "// %s",
            jsx_attribute = "// %s",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            spread_element = "// %s",
            statement_block = "// %s",
        },
        twig = "{# %s #}",
        typescript = { "// %s", "/* %s */" },
        vue = "<!-- %s -->",
        xaml = "<!-- %s -->",
    },
})

require("trouble").setup({
    auto_close = true,
    auto_refresh = true,
    focus = true,
    follow = true,
    modes = {
        preview_float = {
            mode = "diagnostics",
            preview = {
                border = "rounded",
                position = { 0, -2 },
                relative = "editor",
                size = { height = 0.4, width = 0.4 },
                title = "Preview",
                title_pos = "center",
                type = "float",
                zindex = 200,
            },
        },
    },
    open_no_results = true,
})

require("treesitter-context").setup({ max_lines = 4, min_window_height = 40, multiwindow = true, separator = "-" })

vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
require("nvim-treesitter.configs").setup({
    highlight = {
        additional_vim_regex_highlighting = true,
        disable = function(lang, bufnr)
            return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_decremental = "grm",
            node_incremental = "grn",
            scope_incremental = "grc",
        },
    },
    indent = { enable = true },
    matchup = { enable = false },
    parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
    refactor = {
        highlight_current_scope = { enable = false },
        highlight_definitions = { clear_on_cursor_move = true, enable = true },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
            },
        },
        smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
    },
})

require("project_nvim").setup({})

require("otter").setup({
    buffers = { set_filetype = true },
    handle_leading_whitespace = true,
    lsp = { diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" } },
})

require("nvim-lightbulb").setup({
    autocmd = { enabled = true, updatetime = 200 },
    line = { enabled = true },
    number = { enabled = true },
    sign = { enabled = true, text = " 󰌶" },
    status_text = { enabled = true, text = " 󰌶 " },
})

require("nvim-autopairs").setup({ check_ts = true })

vim.notify = require("notify")

require("notify").setup({})

require("noice").setup({
    cmdline = {
        format = {
            cmdline = { icon = "", lang = "vim", opts = { border = { text = { top = "Cmd" } } }, pattern = "^:" },
            filter = {
                icon = "",
                lang = "bash",
                opts = { border = { text = { top = "Bash" } } },
                pattern = "^:%s*!",
            },
            help = { icon = "󰋖", pattern = "^:%s*he?l?p?%s+" },
            lua = { icon = "", lang = "lua", pattern = "^:%s*lua%s+" },
            search_down = { icon = " ", kind = "search", lang = "regex", pattern = "^/" },
            search_up = { icon = " ", kind = "search", lang = "regex", pattern = "^%?" },
        },
    },
    lsp = {
        override = {
            ["cmp.entry.get_documentation"] = true,
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
        progress = { enabled = true },
        signature = { enabled = false },
    },
    messages = { view = "mini", view_error = "mini", view_warn = "mini" },
    popupmenu = { backend = "nui" },
    presets = {
        bottom_search = false,
        command_palette = true,
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
    routes = {
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
        {
            filter = {
                cond = function(message)
                    local client = vim.tbl_get(message.opts, "progress", "client")
                    local servers = { "jdtls" }

                    for index, value in ipairs(servers) do
                        if value == client then
                            return true
                        end
                    end
                end,
                event = "lsp",
                kind = "progress",
            },
            opts = { skip = true },
        },
    },
    views = {
        cmdline_popup = { border = { style = "single" } },
        confirm = { border = { style = "single", text = { top = "" } } },
    },
})

require("neoscroll").setup({})

require("nvim-navic").setup({ lsp = { auto_attach = true } })

require("lualine").setup({
    options = {
        disabled_filetypes = {
            "startify",
            "neo-tree",
            statusline = { "dap-repl" },
            winbar = { "aerial", "dap-repl", "neotest-summary" },
        },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename", "diff" },
        lualine_x = {
            "diagnostics",
            {
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                color = { fg = "#ffffff" },
                icon = "",
            },
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = {
            {
                "aerial",
                colored = true,
                cond = function()
                    local buf_size_limit = 1024 * 1024
                    if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                        return false
                    end

                    return true
                end,
                dense = false,
                dense_sep = ".",
                depth = nil,
                sep = " ) ",
            },
        },
        lualine_z = { { "location" } },
    },
    winbar = {
        lualine_c = { { "navic" } },
        lualine_x = { { "filename", newfile_status = true, path = 3, shorting_target = 150 } },
    },
})

require("nvim-lastplace").setup({})

require("ibl").setup({})

require("inc_rename").setup({})

require("hardtime").setup({ disable_mouse = false })

require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 500,
        ignore_blank_lines = true,
        ignore_whitespace = true,
        virt_text = true,
        virt_text_pos = "eol",
    },
    signcolumn = false,
})

require("git-worktree").setup({})

require("git-conflict").setup({
    default_mappings = { both = "cb", next = "]x", none = "c0", ours = "co", prev = "[x", theirs = "ct" },
})

require("flash").setup({
    modes = { char = { jump_labels = true } },
    search = {
        exclude = {
            "notify",
            "cmp_menu",
            "noice",
            "flash_prompt",
            function(win)
                -- exclude non-focusable windows
                return not vim.api.nvim_win_get_config(win).focusable
            end,
        },
    },
})

require("fastaction").setup({})

require("debugprint").setup({})

require("nvim-cursorline").setup({})

require("csvview").setup({})

require("copilot").setup({
    copilot_node_command = "/nix/store/cnyxnqdcmc08803c4lc8iwiszpa482hy-nodejs-18.20.6/bin/node",
    panel = { enabled = false },
    suggestion = { enabled = false },
})

local slow_format_filetypes = {}

require("conform").setup({
    default_format_opts = { lsp_format = "fallback" },
    format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
        end

        return { lsp_fallback = true }
    end,
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        -- Disable autoformat for slow filetypes
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
        end

        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") or bufname:match("/.direnv/") then
            return
        end

        local function on_format(err)
            if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
        end

        return { timeout_ms = 200, lsp_fallback = true }, on_format
    end,
    formatters = {
        bicep = { command = "/nix/store/abqg215iciz3aqjgx47810az62qhg477-bicep-0.32.4/bin/bicep" },
        biome = { command = "/nix/store/kp91h8pd6xi8kgf17vv3qk2kqv813980-biome-1.9.4/bin/biome" },
        black = { command = "/nix/store/z11xydlv01159zbkkpkf01a7g81r7007-python3.12-black-24.8.0/bin/black" },
        ["cmake-format"] = {
            command = "/nix/store/mb7zdjxjwgn4crcg74icf3qb2afhpr9a-cmake-format-0.6.13/bin/cmake-format",
        },
        csharpier = { command = "/nix/store/qphzxw84ahjxp9852xjgffhdlr6yhlkv-csharpier-0.30.6/bin/dotnet-csharpier" },
        deno_fmt = { command = "/nix/store/jh4ivfl9agj29dnj6ww9ax5cbxnql9j2-deno-2.1.7/bin/deno" },
        fantomas = { command = "/nix/store/3jycgd4bbl0aw1m5iphx8hld2qgs4rxf-fantomas-7.0.0/bin/fantomas" },
        gdformat = { command = "/nix/store/5d5svbjdzxb8vz8i6kfyh4mv5h2dwx10-gdtoolkit-4.3.1/bin/gdformat" },
        ["google-java-format"] = {
            command = "/nix/store/ysq79irjjk4bbc4zl9my0739xs81mfj6-google-java-format-1.25.2/bin/google-java-format",
        },
        isort = { command = "/nix/store/ymrpwz6ablhz4b47mv3m3nqvyjkwq573-python3.12-isort-5.13.2/bin/isort" },
        jq = { command = "/nix/store/69msxmwsxfbxx8mzigzrfppgz6qk1sx8-jq-1.7.1-bin/bin/jq" },
        nixfmt = { command = "/nix/store/5437izm22g3084vsh0jmqmazgrdgib5n-nixfmt-unstable-2024-12-04/bin/nixfmt" },
        prettierd = { command = "/nix/store/anbbn4a3xaagq8jcifyhh2lwmcjf433j-prettierd-0.25.3/bin/prettierd" },
        ruff = { command = "/nix/store/ym9szcqn6h3r8cgvcf50qlms4pizpys5-ruff-0.9.2/bin/ruff" },
        rustfmt = { command = "/nix/store/00h51vwbfcylzx6rl2p8dh6dq3yz9nlv-rustfmt-1.83.0/bin/rustfmt" },
        shellcheck = { command = "/nix/store/d578igb56crc28zrx914mqxbc88djhk5-shellcheck-0.10.0-bin/bin/shellcheck" },
        shellharden = { command = "/nix/store/gz1cf5jzr7k5cxi6cajhgypqzdcxzv9a-shellharden-4.3.1/bin/shellharden" },
        shfmt = { command = "/nix/store/ca6k9rhbch5z7axmxrc6zsz0lm65cjwq-shfmt-3.10.0/bin/shfmt" },
        sqlfluff = { command = "/nix/store/avpgyxjvar4h1h483g7fgvgicv7gs1yc-sqlfluff-3.3.0/bin/sqlfluff" },
        squeeze_blanks = { command = "/nix/store/pw26z7msfmv291jq1qpp8bbaprs5hkfk-coreutils-9.5/bin/cat" },
        stylelint = { command = "/nix/store/n1bvyzg5bj7nra3s9f2d6cxajqfvblly-stylelint-16.13.0/bin/stylelint" },
        stylua = { command = "/nix/store/d2kll4ywb917dgljvv7dj2zmbh6g2459-stylua-2.0.2/bin/stylua" },
        swift_format = { command = "/nix/store/ik2z1mx2b6ayk505fnvp9q8k4z3l0lj6-swift-format-5.8/bin/swift-format" },
        taplo = { command = "/nix/store/x67l4nckcrda85537z9y40ffw4mrml0a-taplo-0.9.3/bin/taplo" },
        terraform_fmt = { command = "/nix/store/q1lx1sv4qmb6pqm3gzaclbrc8la00kl6-terraform-1.10.5/bin/terraform" },
        xmlformat = { command = "/nix/store/0sapmycs8pynnd400y7ipi9kzbhab3ay-xmlformat-1.04/bin/xmlformat" },
        yamlfmt = { command = "/nix/store/6jsn1y2bspnka17rqqyh63aw89n0js91-yamlfmt-0.15.0/bin/yamlfmt" },
        zigfmt = { command = "/nix/store/86rlyw6lclib33kbghisr57knpy4wq96-zig-0.13.0/bin/zig" },
    },
    formatters_by_ft = {
        _ = { "squeeze_blanks", "trim_whitespace", "trim_newlines" },
        bash = { "shellcheck", "shellharden", "shfmt" },
        bicep = { "bicep" },
        c = { "clang_format" },
        cmake = { "cmake-format" },
        cpp = { "clang_format" },
        cs = { "csharpier" },
        css = { "stylelint" },
        fish = { "fish_indent" },
        fsharp = { "fantomas" },
        gdscript = { "gdformat" },
        java = { "google-java-format" },
        javascript = { "biome", "prettierd", stop_after_first = true, timeout_ms = 2000 },
        json = { "jq" },
        lua = { "stylua" },
        markdown = { "deno_fmt" },
        nix = { "nixfmt" },
        python = { "isort", "ruff" },
        rust = { "rustfmt" },
        sh = { "shellcheck", "shellharden", "shfmt" },
        sql = { "sqlfluff" },
        swift = { "swift_format" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
        typescript = { "biome", "prettierd", stop_after_first = true, timeout_ms = 2000 },
        xml = { "xmlformat", "xmllint" },
        yaml = { "yamlfmt" },
        zig = { "zigfmt" },
    },
})

require("codecompanion").setup({
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    api_key = "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",
                },
                schema = {
                    model = {
                        default = "o1-mini-2024-09-12",
                    },
                },
            })
        end,
    },
    opts = { log_level = "DEBUG" },
    strategies = { chat = { adapter = "openai" }, inline = { adapter = "openai" } },
})

require("cmp_git").setup({})

require("blink-compat").setup({ debug = true, impersonate_nvim_cmp = true })

require("blink-cmp").setup({
    appearance = { use_nvim_cmp_as_default = true },
    completion = {
        documentation = { auto_show = true, window = { border = "rounded" } },
        ghost_text = { enabled = true },
        list = { selection = { auto_insert = true, preselect = false } },
        menu = {
            border = "rounded",
            draw = {
                columns = { { "label" }, { "kind_icon", "kind", gap = 1 }, { "source_name" } },
                components = {
                    kind_icon = {
                        ellipsis = false,
                        text = function(ctx)
                            local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                            return kind_icon
                        end,
                        -- Optionally, you may also use the highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
    },
    fuzzy = { prebuilt_binaries = { download = false, ignore_version_mismatch = true } },
    keymap = {
        ["<A-S-Tab>"] = { "snippet_backward", "fallback" },
        ["<A-Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        preset = "enter",
    },
    signature = { enabled = true, window = { border = "rounded" } },
    snippets = { preset = "mini_snippets" },
    sources = {
        default = {
            "buffer",
            "lsp",
            "path",
            "snippets",
            "codecompanion",
            "copilot",
            "ripgrep",
            "calc",
            "git",
            "spell",
            "zsh",
            "cmp-vimwiki-tags",
        },
        providers = {
            calc = { module = "blink.compat.source", name = "calc", score_offset = 2 },
            ["cmp-vimwiki-tags"] = { module = "blink.compat.source", name = "cmp-vimwiki-tags", score_offset = 0 },
            codecompanion = {
                enabled = true,
                module = "codecompanion.providers.completion.blink",
                name = "CodeCompanion",
                score_offset = 110,
            },
            copilot = { async = true, module = "blink-cmp-copilot", name = "copilot", score_offset = 100 },
            git = { module = "blink.compat.source", name = "git", score_offset = 0 },
            lsp = { score_offset = 4 },
            npm = { module = "blink.compat.source", name = "npm", score_offset = -3 },
            ripgrep = { module = "blink-ripgrep", name = "Ripgrep", score_offset = 1 },
            spell = { module = "blink.compat.source", name = "spell", score_offset = -1 },
            zsh = { module = "blink.compat.source", name = "zsh", score_offset = -3 },
        },
    },
})

require("better_escape").setup({ mapping = { "jj", "jk" }, timeout = 500 })

require("autoclose").setup({})

require("auto-session").setup({
    auto_restore = true,
    auto_save = true,
    bypass_save_filetypes = { "alpha", "dashboard", "markdown", ".md", "neo-tree", "neotree" },
    create_enabled = true,
    cwd_change_handling = false,
    enable_last_session = false,
    log_level = "info",
    root_dir = "$XDG_SESSIONS_DIR/",
    session_lens = {
        load_on_setup = true,
        previewer = true,
        session_control = {
            controlDir = "$XDG_SESSIONS_DIR/",
            controlFilename = "$XDG_SESSIONS_DIR/session_control.json",
        },
    },
    suppress_dirs = { "~/.cache", "~/.local/share", "/tmp", "/var/tmp", "$XDG_PROJECTS_DIR", "$ZK_NOTEBOOK_DIR" },
    use_git_branch = true,
})

require("auto-save").setup({ write_all_buffers = true })

require("bqf").setup({})

require("neo-tree").setup({
    close_if_last_window = true,
    document_symbols = { custom_kinds = {} },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
            never_show_by_pattern = { ".direnv", ".git" },
            visible = true,
        },
        follow_current_file = { enabled = true, leaveDirsOpen = true },
        use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
    },
    window = { auto_expand_width = false, width = 40 },
})

require("lspkind").init({})

require("illuminate").configure({
    filetypes_denylist = { "dirvish", "fugitive", "neo-tree", "TelescopePrompt" },
    large_file_cutoff = 3000,
})

require("harpoon").setup({
    global_settings = {
        enter_on_sendcmd = true,
        excluded_filetypes = { "harpoon", "alpha", "NvimTree" },
        mark_branch = true,
        save_on_change = true,
    },
})
require("telescope").load_extension("harpoon")

require("diffview").setup({ use_icons = true })

-- Set up keybinds {{{
do
    local __nixvim_binds = {
        { action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", key = "<leader>ft", mode = "n" },
        { action = "<cmd>TodoTrouble<cr>", key = "<leader>uq", mode = "n" },
        { action = "<cmd>Telescope marks<cr>", key = "<leader>f'", mode = "n", options = { desc = "View marks" } },
        {
            action = "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            key = "<leader>f/",
            mode = "n",
            options = { desc = "Fuzzy find in current buffer" },
        },
        {
            action = "<cmd>Telescope resume<cr>",
            key = "<leader>f<CR>",
            mode = "n",
            options = { desc = "Resume action" },
        },
        {
            action = "<cmd>Telescope autocommands<cr>",
            key = "<leader>fa",
            mode = "n",
            options = { desc = "View autocommands" },
        },
        { action = "<cmd>Telescope buffers<cr>", key = "<leader>fb", mode = "n", options = { desc = "View buffers" } },
        { action = "<cmd>Telescope commands<cr>", key = "<leader>fc", mode = "n", options = { desc = "View commands" } },
        {
            action = "<cmd>Telescope diagnostics<cr>",
            key = "<leader>fd",
            mode = "n",
            options = { desc = "View diagnostics" },
        },
        { action = "<cmd>Telescope find_files<cr>", key = "<leader>ff", mode = "n", options = { desc = "Find files" } },
        {
            action = "<cmd>Telescope help_tags<cr>",
            key = "<leader>fh",
            mode = "n",
            options = { desc = "View help tags" },
        },
        { action = "<cmd>Telescope keymaps<cr>", key = "<leader>fk", mode = "n", options = { desc = "View keymaps" } },
        {
            action = "<cmd>Telescope man_pages<cr>",
            key = "<leader>fm",
            mode = "n",
            options = { desc = "View man pages" },
        },
        {
            action = "<cmd>Telescope oldfiles<cr>",
            key = "<leader>fo",
            mode = "n",
            options = { desc = "View old files" },
        },
        {
            action = "<cmd>Telescope quickfix<cr>",
            key = "<leader>fq",
            mode = "n",
            options = { desc = "Search quickfix" },
        },
        {
            action = "<cmd>Telescope registers<cr>",
            key = "<leader>fr",
            mode = "n",
            options = { desc = "View registers" },
        },
        {
            action = "<cmd>Telescope lsp_document_symbols<cr>",
            key = "<leader>fs",
            mode = "n",
            options = { desc = "Search symbols" },
        },
        { action = "<cmd>Telescope live_grep<cr>", key = "<leader>fw", mode = "n", options = { desc = "Live grep" } },
        {
            action = "<cmd>Telescope git_branches<cr>",
            key = "<leader>gB",
            mode = "n",
            options = { desc = "View git branches" },
        },
        {
            action = "<cmd>Telescope git_commits<cr>",
            key = "<leader>gC",
            mode = "n",
            options = { desc = "View git commits" },
        },
        {
            action = "<cmd>Telescope git_stash<cr>",
            key = "<leader>gS",
            mode = "n",
            options = { desc = "View git stashes" },
        },
        {
            action = "<cmd>Telescope git_status<cr>",
            key = "<leader>gs",
            mode = "n",
            options = { desc = "View git status" },
        },
        { action = require("harpoon.mark").add_file, key = "<leader>ha", mode = "n", options = { silent = true } },
        {
            action = require("harpoon.ui").toggle_quick_menu,
            key = "<leader>he",
            mode = "n",
            options = { silent = true },
        },
        {
            action = function()
                require("harpoon.ui").nav_file(1)
            end,
            key = "<leader>hj",
            mode = "n",
            options = { silent = true },
        },
        {
            action = function()
                require("harpoon.ui").nav_file(2)
            end,
            key = "<leader>hk",
            mode = "n",
            options = { silent = true },
        },
        {
            action = function()
                require("harpoon.ui").nav_file(3)
            end,
            key = "<leader>hl",
            mode = "n",
            options = { silent = true },
        },
        {
            action = function()
                require("harpoon.ui").nav_file(4)
            end,
            key = "<leader>hm",
            mode = "n",
            options = { silent = true },
        },
        { action = ":", key = ";", mode = "" },
        { action = "<NOP>", key = "<Space>", mode = "" },
        { action = "<BS>x", key = "<BS>", mode = "" },
        { action = "y$", key = "Y", mode = "" },
        { action = "<cmd>b#<CR>", key = "<C-c>", mode = "" },
        { action = "<cmd>cprev<CR>", key = "<C-]>", mode = "" },
        { action = ":w<CR>", key = "<leader>s", mode = "", options = { silent = true } },
        { action = ":wa!<CR>", key = "<leader>S", mode = "", options = { silent = true } },
        { action = ":w<CR>", key = "<C-s>w", mode = "", options = { silent = true } },
        { action = ":split<CR>", key = "vs", mode = "", options = { silent = true } },
        { action = ":vsplit<CR>", key = "vv", mode = "", options = { silent = true } },
        { action = ":bd<CR>", key = "<leader>bq", mode = "", options = { silent = true } },
        { action = "<C-w>h", key = "<C-h>", mode = "", options = { silent = true } },
        { action = "<C-w>j", key = "<C-j>", mode = "", options = { silent = true } },
        { action = "<C-w>l", key = "<C-l>", mode = "", options = { silent = true } },
        { action = "<C-w>k", key = "<C-k>", mode = "", options = { silent = true } },
        { action = ":vertical resize +2<CR>", key = "<C-Left>", mode = "", options = { silent = true } },
        { action = ":vertical resize -2<CR>", key = "<C-Right>", mode = "", options = { silent = true } },
        { action = ":resize +2<CR>", key = "<C-Down>", mode = "", options = { silent = true } },
        { action = ":resize -2<CR>", key = "<C-Up>", mode = "", options = { silent = true } },
        { action = "<Cmd>enew<CR>", key = "<C-n>", mode = "" },
        { action = "(v:count == 0 ? 'gj' : 'j')", key = "j", mode = "", options = { expr = true, silent = true } },
        { action = "(v:count == 0? 'gk' : 'k')", key = "k", mode = "", options = { expr = true, silent = true } },
        { action = ":m '>+1<CR>gv=gv", key = "J", mode = "v", options = { silent = true } },
        { action = ":m '<-2<CR>gv=gv", key = "K", mode = "v", options = { silent = true } },
        { action = "<gv", key = "<s-tab>", mode = "x", options = { silent = true } },
        { action = ">gv", key = "<tab>", mode = "x", options = { silent = true } },
        { action = "Nzzzv", key = "N", mode = "", options = { silent = true } },
        { action = "nzzzv", key = "n", mode = "", options = { silent = true } },
        { action = "<Cmd>q!<CR>", key = "<leader>Q", mode = "" },
        { action = "", key = "<M-Q>", mode = "", options = { noremap = false, unique = true } },
        { action = ":nohl<CR>", key = "<esc>", mode = "", options = { noremap = false, silent = true, unique = true } },
        { action = "p`]", key = "p", mode = "", options = { silent = true } },
        { action = "y`]", key = "y", mode = "v", options = { silent = true } },
        { action = "py`]", key = "p", mode = "v", options = { silent = true } },
        { action = '"+p', key = "<leader>p", mode = "", options = { noremap = false, silent = true } },
        { action = '"+y', key = "<leader>y", mode = "", options = { noremap = false, silent = true } },
        { action = ":q<CR>", key = "<C-q>", mode = "", options = { noremap = false, silent = true } },
        { action = ":bprevious<CR>", key = "[b", mode = "", options = { silent = true } },
        { action = ":bnext<CR>", key = "]b", mode = "", options = { silent = true } },
        { action = "<cmd>bnext<CR>", key = "<TAB>", mode = "" },
        { action = "<cmd>bprevious<CR>", key = "<S-TAB>", mode = "" },
        {
            action = ":ZkNew { title = vim.fn.input('Title: ')}<CR>",
            key = "<leader>zn",
            mode = "",
            options = { desc = "Create a new note with specified title", silent = true },
        },
        {
            action = ":ZkNotes { sort = {'modified'} }<CR>",
            key = "<leader>zo",
            mode = "",
            options = { desc = "Open zk notes without search", silent = true },
        },
        { action = ":ZkTags<CR>", key = "<leader>zt", mode = "", options = { desc = "Open tags", silent = true } },
        {
            action = ":ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
            key = "<leader>zf",
            mode = "",
            options = { desc = "Opens notes sorted by modified date with search ", silent = true },
        },
        {
            action = ":'<,'>ZkMatch<CR>",
            key = "<leader>zf",
            mode = "v",
            options = {
                desc = " Opens a notes picker, filters for notes that match the text in the last visual selection ",
                silent = true,
            },
        },
        {
            action = "<cmd>BufferLineTogglePin<cr>",
            key = "<leader>bP",
            mode = "n",
            options = { desc = "Pin buffer toggle" },
        },
        { action = "<cmd>BufferLinePick<cr>", key = "<leader>bp", mode = "n", options = { desc = "Pick Buffer" } },
        {
            action = "<cmd>BufferLineSortByDirectory<cr>",
            key = "<leader>bsd",
            mode = "n",
            options = { desc = "Sort By Directory" },
        },
        {
            action = "<cmd>BufferLineSortByExtension<cr>",
            key = "<leader>bse",
            mode = "n",
            options = { desc = "Sort By Extension" },
        },
        {
            action = "<cmd>BufferLineSortByRelativeDirectory<cr>",
            key = "<leader>bsr",
            mode = "n",
            options = { desc = "Sort By Relative Directory" },
        },
        { action = "<cmd>CBd<cr>", key = "<leader>Cd", mode = "n", options = { desc = "Delete a box" } },
        { action = "<cmd>CBccbox<cr>", key = "<leader>Cb", mode = "n", options = { desc = "Box Title" } },
        { action = "<cmd>CBllline<cr>", key = "<leader>Ct", mode = "n", options = { desc = "Titled Line" } },
        { action = "<cmd>CBline<cr>", key = "<leader>Cl", mode = "n", options = { desc = "Simple Line" } },
        { action = "<cmd>CodeSnap<CR>", key = "<leader>cc", mode = "v", options = { desc = "Copy" } },
        { action = "<cmd>CodeSnapSave<CR>", key = "<leader>cs", mode = "v", options = { desc = "Save" } },
        { action = "<cmd>CodeSnapHighlight<CR>", key = "<leader>ch", mode = "v", options = { desc = "Highlight" } },
        {
            action = "<cmd>CodeSnapSaveHighlight<CR>",
            key = "<leader>cH",
            mode = "v",
            options = { desc = "Save Highlight" },
        },
        {
            action = function()
                vim.g.colorizing_enabled = not vim.g.colorizing_enabled
                vim.cmd("ColorizerToggle")
                vim.notify(string.format("Colorizing %s", bool2str(vim.g.colorizing_enabled), "info"))
            end,
            key = "<leader>uC",
            mode = "n",
            options = { desc = "Colorizing toggle", silent = true },
        },
        { action = "<cmd>CopilotChat<CR>", key = "<leader>ac", mode = "n", options = { desc = "Copilot Chat" } },
        {
            action = function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                end
            end,
            key = "<leader>aq",
            mode = "n",
            options = { desc = "Quick Chat" },
        },
        {
            action = function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.help_actions())
            end,
            key = "<leader>ah",
            mode = "n",
            options = { desc = "Help Actions" },
        },
        {
            action = function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end,
            key = "<leader>ap",
            mode = "n",
            options = { desc = "Prompt Actions" },
        },
        {
            action = "<cmd>CodeCompanionChat<CR>",
            key = "<leader>ch",
            mode = "n",
            options = { desc = "CodeCompanionChat" },
        },
        {
            action = "<cmd>CodeCompanionActions<CR>",
            key = "<leader>ca",
            mode = "n",
            options = { desc = "CodeCompanionActions" },
        },
        {
            action = "<cmd>CodeCompanionCmd<CR>",
            key = "<leader>cm",
            mode = "n",
            options = { desc = "CodeCompanionCmd" },
        },
        {
            action = function()
                vim.g.diffview_enabled = not vim.g.diffview_enabled
                if vim.g.diffview_enabled then
                    vim.cmd("DiffviewClose")
                else
                    vim.cmd("DiffviewOpen")
                end
            end,
            key = "<leader>gd",
            mode = "n",
            options = { desc = "Git Diff toggle", silent = true },
        },
        {
            action = function()
                require("flash").jump()
            end,
            key = "s",
            mode = { "n", "x", "o" },
            options = { desc = "Flash" },
        },
        {
            action = function()
                require("flash").treesitter()
            end,
            key = "S",
            mode = { "n", "x", "o" },
            options = { desc = "Flash Treesitter" },
        },
        {
            action = function()
                require("flash").remote()
            end,
            key = "r",
            mode = { "o" },
            options = { desc = "Remote Flash" },
        },
        {
            action = function()
                require("flash").treesitter_search()
            end,
            key = "R",
            mode = { "o" },
            options = { desc = "Treesitter Search" },
        },
        {
            action = function()
                require("flash").jump({
                    search = { mode = "search", max_length = 0 },
                    label = { after = { 0, 0 } },
                    pattern = "^",
                })
            end,
            key = "gl",
            mode = { "n", "x", "o" },
            options = { desc = "Flash Line" },
        },
        { action = "<cmd>GitConflictNextConflict<CR>", key = "<leader>gc]", mode = "n", options = { desc = "Next" } },
        { action = "<cmd>GitConflictPrevConflict<CR>", key = "<leader>gc[", mode = "n", options = { desc = "Prev" } },
        { action = "<cmd>GitConflictRefresh<CR>", key = "<leader>gcr", mode = "n", options = { desc = "Refresh" } },
        {
            action = "<cmd>GitConflictChooseBase<CR>",
            key = "<leader>gcb",
            mode = "n",
            options = { desc = "Choose Base" },
        },
        {
            action = "<cmd>GitConflictChooseBoth<CR>",
            key = "<leader>gcB",
            mode = "n",
            options = { desc = "Choose Both" },
        },
        {
            action = "<cmd>GitConflictChooseTheirs<CR>",
            key = "<leader>gct",
            mode = "n",
            options = { desc = "Choose Theirs" },
        },
        {
            action = "<cmd>GitConflictChooseOurs<CR>",
            key = "<leader>gco",
            mode = "n",
            options = { desc = "Choose Ours" },
        },
        {
            action = "<cmd>GitConflictChooseNone<CR>",
            key = "<leader>gcn",
            mode = "n",
            options = { desc = "Choose None" },
        },
        { action = "<cmd>GitConflictListQf<CR>", key = "<leader>gcl", mode = "n", options = { desc = "List" } },
        {
            action = "<cmd>lua require('fastaction').code_action()<cr>",
            key = "<leader>lc",
            mode = "n",
            options = { desc = "Fastaction code action" },
        },
        {
            action = "<cmd>lua require('fastaction').range_code_action()<cr>",
            key = "<leader>lc",
            mode = "v",
            options = { desc = "Fastaction code action" },
        },
        {
            action = "<cmd>Gitsigns toggle_current_line_blame<CR>",
            key = "<leader>ugb",
            mode = "n",
            options = { desc = "Git Blame toggle" },
        },
        {
            action = "<cmd>Gitsigns toggle_deleted<CR>",
            key = "<leader>ugd",
            mode = "n",
            options = { desc = "Deleted toggle" },
        },
        {
            action = "<cmd>Gitsigns toggle_linehl<CR>",
            key = "<leader>ugl",
            mode = "n",
            options = { desc = "Line Highlight toggle" },
        },
        {
            action = "<cmd>Gitsigns toggle_numhl<CR>",
            key = "<leader>ugh",
            mode = "n",
            options = { desc = "Number Highlight toggle" },
        },
        {
            action = "<cmd>Gitsigns toggle_word_diff<CR>",
            key = "<leader>ugw",
            mode = "n",
            options = { desc = "Word Diff toggle" },
        },
        {
            action = "<cmd>Gitsigns toggle_signs<CR>",
            key = "<leader>ugs",
            mode = "n",
            options = { desc = "Signs toggle" },
        },
        {
            action = function()
                require("gitsigns").blame_line({ full = true })
            end,
            key = "<leader>gb",
            mode = "n",
            options = { desc = "Git Blame toggle", silent = true },
        },
        {
            action = function()
                if vim.wo.diff then
                    return "<leader>gp"
                end

                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)

                return "<Ignore>"
            end,
            key = "<leader>ghp",
            mode = "n",
            options = { desc = "Previous hunk", silent = true },
        },
        {
            action = function()
                if vim.wo.diff then
                    return "<leader>gn"
                end

                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)

                return "<Ignore>"
            end,
            key = "<leader>ghn",
            mode = "n",
            options = { desc = "Next hunk", silent = true },
        },
        {
            action = "<cmd>Gitsigns stage_hunk<CR>",
            key = "<leader>ghs",
            mode = { "n", "v" },
            options = { desc = "Stage hunk" },
        },
        {
            action = "<cmd>Gitsigns undo_stage_hunk<CR>",
            key = "<leader>ghu",
            mode = "n",
            options = { desc = "Undo stage hunk" },
        },
        {
            action = "<cmd>Gitsigns reset_hunk<CR>",
            key = "<leader>ghr",
            mode = { "n", "v" },
            options = { desc = "Reset hunk" },
        },
        {
            action = "<cmd>Gitsigns preview_hunk<CR>",
            key = "<leader>ghP",
            mode = "n",
            options = { desc = "Preview hunk" },
        },
        {
            action = "<cmd>Gitsigns preview_hunk_inline<CR>",
            key = "<leader>gh<C-p>",
            mode = "n",
            options = { desc = "Preview hunk inline" },
        },
        {
            action = "<cmd>Gitsigns stage_buffer<CR>",
            key = "<leader>gS",
            mode = "n",
            options = { desc = "Stage buffer" },
        },
        {
            action = "<cmd>Gitsigns reset_buffer<CR>",
            key = "<leader>gR",
            mode = "n",
            options = { desc = "Reset buffer" },
        },
        {
            action = "<CMD>Glance definitions<CR>",
            key = "<leader>lgd",
            mode = "n",
            options = { desc = "Glance definition" },
        },
        {
            action = "<CMD>Glance implementations<CR>",
            key = "<leader>lgi",
            mode = "n",
            options = { desc = "Glance implementation" },
        },
        {
            action = "<CMD>Glance references<CR>",
            key = "<leader>lgr",
            mode = "n",
            options = { desc = "Glance reference" },
        },
        {
            action = "<CMD>Glance type_definitions<CR>",
            key = "<leader>lgt",
            mode = "n",
            options = { desc = "Glance type definition" },
        },
        {
            action = "<cmd>Telescope git_worktree<CR>",
            key = "<leader>fg",
            mode = "n",
            options = { desc = "Git Worktree" },
        },
        {
            action = function()
                require("telescope").extensions.git_worktree.create_git_worktree()
            end,
            key = "<leader>gWc",
            mode = "n",
            options = { desc = "Create worktree", silent = true },
        },
        {
            action = function()
                require("telescope").extensions.git_worktree.git_worktrees()
            end,
            key = "<leader>gWs",
            mode = "n",
            options = { desc = "Switch / Delete worktree", silent = true },
        },
        {
            action = require("gitignore").generate,
            key = "<leader>gi",
            mode = "n",
            options = { desc = "Gitignore generate", silent = true },
        },
        { action = "<cmd>GrugFar<CR>", key = "<leader>rg", mode = "n", options = { desc = "GrugFar toggle" } },
        {
            action = function()
                vim.g.disable_hardtime = not vim.g.disable_hardtime
                if vim.g.disable_hardtime then
                    require("hardtime").disable()
                else
                    require("hardtime").enable()
                end
                vim.notify(string.format("Hardtime %s", bool2str(not vim.g.disable_hardtime), "info"))
            end,
            key = "<leader>vh",
            mode = "n",
            options = { desc = "Hardtime toggle", silent = true },
        },
        {
            action = "<cmd>IBLToggle<CR>",
            key = "<leader>ui",
            mode = "n",
            options = { desc = "Indent-Blankline toggle" },
        },
        {
            action = "<cmd>IBLToggleScope<CR>",
            key = "<leader>uI",
            mode = "n",
            options = { desc = "Indent-Blankline Scope toggle" },
        },
        { action = "<cmd>MarkdownPreview<cr>", key = "<leader>pm", mode = "n", options = { desc = "Markdown Preview" } },
        {
            action = require("mini.bufremove").delete,
            key = "<leader>cc",
            mode = "n",
            options = { desc = "Close buffer", silent = true },
        },
        {
            action = function()
                local current = vim.api.nvim_get_current_buf()

                local get_listed_bufs = function()
                    return vim.tbl_filter(function(bufnr)
                        return vim.api.nvim_buf_get_option(bufnr, "buflisted")
                    end, vim.api.nvim_list_bufs())
                end

                for _, bufnr in ipairs(get_listed_bufs()) do
                    if bufnr ~= current then
                        require("mini.bufremove").delete(bufnr)
                    end
                end
            end,
            key = "<leader>bc",
            mode = "n",
            options = { desc = "Close all buffers but current" },
        },
        {
            action = MiniMap.toggle,
            key = "<leader>um",
            mode = "n",
            options = { desc = "MiniMap toggle", silent = true },
        },
        {
            action = "<cmd>Neotree action=focus reveal toggle<CR>",
            key = "-",
            mode = "n",
            options = { desc = "Explorer toggle" },
        },
        {
            action = "<cmd>Telescope noice<CR>",
            key = "<leader>fn",
            mode = "n",
            options = { desc = "Find notifications" },
        },
        {
            action = "<cmd>TSContextToggle<cr>",
            key = "<leader>ut",
            mode = "n",
            options = { desc = "Treesitter Context toggle" },
        },
        {
            action = function()
                require("telescope.builtin").find_files({
                    prompt_title = "Config Files",
                    cwd = vim.fn.stdpath("config"),
                    follow = true,
                })
            end,
            key = "<leader>fC",
            mode = "n",
            options = { desc = "Find config files", silent = true },
        },
        {
            action = function()
                require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
            end,
            key = "<leader>fF",
            mode = "n",
            options = { desc = "Find all files", silent = true },
        },
        {
            action = function()
                require("telescope.builtin").colorscheme({ enable_preview = true })
            end,
            key = "<leader>fT",
            mode = "n",
            options = { desc = "Find theme", silent = true },
        },
        {
            action = function()
                require("telescope.builtin").live_grep({
                    additional_args = function(args)
                        return vim.list_extend(args, { "--hidden", "--no-ignore" })
                    end,
                })
            end,
            key = "<leader>fW",
            mode = "n",
            options = { desc = "Find words in all files", silent = true },
        },
        {
            action = function()
                require("telescope.builtin").live_grep({ grep_open_files = true })
            end,
            key = "<leader>f?",
            mode = "n",
            options = { desc = "Find words in all open buffers", silent = true },
        },
        {
            action = "<cmd>Telescope file_browser<CR>",
            key = "<leader>fe",
            mode = "n",
            options = { desc = "File Explorer" },
        },
        {
            action = "<cmd>Telescope frecency<CR>",
            key = "<leader>fO",
            mode = "n",
            options = { desc = "Find Frequent Files" },
        },
        { action = "<cmd>Telescope undo<CR>", key = "<leader>fu", mode = "n", options = { desc = "List undo history" } },
        { action = "<cmd>Telescope manix<CR>", key = "<leader>fM", mode = "n", options = { desc = "Search manix" } },
        {
            action = "<cmd>Telescope live_grep_args<CR>",
            key = "<leader>fw",
            mode = "n",
            options = { desc = "Live grep (args)" },
        },
        { action = "<cmd>Telescope projects<CR>", key = "<leader>fp", mode = "n", options = { desc = "Find projects" } },
        {
            action = "<cmd>Trouble preview_float toggle<cr>",
            key = "<leader>ud",
            mode = "n",
            options = { desc = "Diagnostics toggle" },
        },
        {
            action = "<cmd>Trouble preview_float toggle filter.buf=0<cr>",
            key = "<leader>uD",
            mode = "n",
            options = { desc = "Buffer Diagnostics toggle" },
        },
        { action = "<cmd>ToggleTerm<CR>", key = "<leader>tt", mode = "n", options = { desc = "Open Terminal" } },
        {
            action = function()
                local toggleterm = require("toggleterm.terminal")

                toggleterm.Terminal:new({ cmd = "lazygit", hidden = true }):toggle()
            end,
            key = "<leader>tg",
            mode = "n",
            options = { desc = "Open Lazygit", silent = true },
        },
        {
            action = function()
                local toggleterm = require("toggleterm.terminal")

                toggleterm.Terminal:new({ cmd = "lazygit", hidden = true }):toggle()
            end,
            key = "<leader>gg",
            mode = "n",
            options = { desc = "Open Lazygit", silent = true },
        },
        { action = "<cmd>Refactor extract<cr>", key = "<leader>re", mode = "x", options = { desc = "Extract" } },
        {
            action = "<cmd>Refactor extract_to_file<cr>",
            key = "<leader>rE",
            mode = "x",
            options = { desc = "Extract to file" },
        },
        { action = "cmd>Refactor extract_var<cr>", key = "<leader>rv", mode = "x", options = { desc = "Extract var" } },
        { action = "<cmd>Refactor inline_var<CR>", key = "<leader>ri", mode = "n", options = { desc = "Inline var" } },
        { action = "<cmd>Refactor inline_func<CR>", key = "<leader>rI", mode = "n", options = { desc = "Inline Func" } },
        {
            action = "<cmd>Refactor extract_block<CR>",
            key = "<leader>rb",
            mode = "n",
            options = { desc = "Extract block" },
        },
        {
            action = "<cmd>Refactor extract_block_to_file<CR>",
            key = "<leader>rB",
            mode = "n",
            options = { desc = "Extract block to file" },
        },
        {
            action = function()
                require("telescope").extensions.refactoring.refactors()
            end,
            key = "<leader>fR",
            mode = "n",
            options = { desc = "Refactoring", silent = true },
        },
        { action = "<cmd>Spectre<CR>", key = "<leader>rs", mode = "n", options = { desc = "Spectre toggle" } },
        { action = "<cmd>UndotreeToggle<CR>", key = "<leader>uu", mode = "n", options = { desc = "Undotree toggle" } },
        { action = "<CMD>Yazi<CR>", key = "<leader>e", mode = "n", options = { desc = "Yazi (current file)" } },
        { action = "<CMD>Yazi toggle<CR>", key = "<leader>E", mode = "n", options = { desc = "Yazi (resume)" } },
    }
    for i, map in ipairs(__nixvim_binds) do
        vim.keymap.set(map.mode, map.key, map.action, map.options)
    end
end
-- }}}

vim.filetype.add({
    extension = { avsc = "json", ignore = "gitignore", rasi = "scss" },
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang", [".*helm-chart*.yaml"] = "helm", ["flake.lock"] = "json" },
})

-- Set up autogroups {{
do
    local __nixvim_autogroups = { nixvim_binds_LspAttach = { clear = true } }

    for group_name, options in pairs(__nixvim_autogroups) do
        vim.api.nvim_create_augroup(group_name, options)
    end
end
-- }}
-- Set up autocommands {{
do
    local __nixvim_autocommands = {
        {
            callback = function(args)
                do
                    local __nixvim_binds = {
                        {
                            action = vim.diagnostic.open_float,
                            key = "<leader>lH",
                            mode = "n",
                            options = { desc = "Lsp diagnostic open_float", silent = true },
                        },
                        {
                            action = vim.diagnostic.goto_prev,
                            key = "<leader>l[",
                            mode = "n",
                            options = { desc = "Lsp diagnostic goto_prev", silent = true },
                        },
                        {
                            action = vim.diagnostic.goto_next,
                            key = "<leader>l]",
                            mode = "n",
                            options = { desc = "Lsp diagnostic goto_next", silent = true },
                        },
                        {
                            action = vim.lsp.buf.references,
                            key = "<leader>lD",
                            mode = "n",
                            options = { desc = "Lsp buf references", silent = true },
                        },
                        {
                            action = vim.lsp.buf.code_action,
                            key = "<leader>la",
                            mode = "n",
                            options = { desc = "Lsp buf code_action", silent = true },
                        },
                        {
                            action = vim.lsp.buf.definition,
                            key = "<leader>ld",
                            mode = "n",
                            options = { desc = "Lsp buf definition", silent = true },
                        },
                        {
                            action = vim.lsp.buf.format,
                            key = "<leader>lf",
                            mode = "n",
                            options = { desc = "Lsp buf format", silent = true },
                        },
                        {
                            action = vim.lsp.buf.hover,
                            key = "<leader>lh",
                            mode = "n",
                            options = { desc = "Lsp buf hover", silent = true },
                        },
                        {
                            action = vim.lsp.buf.implementation,
                            key = "<leader>li",
                            mode = "n",
                            options = { desc = "Lsp buf implementation", silent = true },
                        },
                        {
                            action = vim.lsp.buf.rename,
                            key = "<leader>lr",
                            mode = "n",
                            options = { desc = "Lsp buf rename", silent = true },
                        },
                        {
                            action = vim.lsp.buf.type_definition,
                            key = "<leader>lt",
                            mode = "n",
                            options = { desc = "Lsp buf type_definition", silent = true },
                        },
                        {
                            action = vim.lsp.buf.format,
                            key = "<leader>lf",
                            mode = "v",
                            options = { buffer = false, desc = "Format selection", silent = true },
                        },
                        {
                            action = "<CMD>PeekDefinition textDocument/definition<CR>",
                            key = "<leader>lp",
                            mode = "n",
                            options = { desc = "Preview definition" },
                        },
                        {
                            action = "<CMD>PeekDefinition textDocument/typeDefinition<CR>",
                            key = "<leader>lP",
                            mode = "n",
                            options = { desc = "Preview type definition" },
                        },
                    }

                    for i, map in ipairs(__nixvim_binds) do
                        local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
                        vim.keymap.set(map.mode, map.key, map.action, options)
                    end
                end
            end,
            desc = "Load keymaps for LspAttach",
            event = "LspAttach",
            group = "nixvim_binds_LspAttach",
        },
    }

    for _, autocmd in ipairs(__nixvim_autocommands) do
        vim.api.nvim_create_autocmd(autocmd.event, {
            group = autocmd.group,
            pattern = autocmd.pattern,
            buffer = autocmd.buffer,
            desc = autocmd.desc,
            callback = autocmd.callback,
            command = autocmd.command,
            once = autocmd.once,
            nested = autocmd.nested,
        })
    end
end
-- }}
