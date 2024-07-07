return {
    {
        "rcarriga/nvim-dap-ui",
        {
            "rcarriga/nvim-dap-ui",
            keys = {
                {
                    "<leader>du",
                    function()
                        require("dapui").toggle()
                    end,
                    silent = true,
                },
            },
            opts = {
                --icons = { expanded = "∩â¥", collapsed = "∩âÜ", circular = "∩äÉ" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                layouts = {
                    {
                        elements = {
                            { id = "repl", size = 0.30 },
                            { id = "console", size = 0.70 },
                        },
                        size = 0.19,
                        position = "bottom",
                    },
                    {
                        elements = {
                            { id = "scopes", size = 0.30 },
                            { id = "breakpoints", size = 0.20 },
                            { id = "stacks", size = 0.10 },
                            { id = "watches", size = 0.30 },
                        },
                        size = 0.20,
                        position = "right",
                    },
                },
                controls = {
                    enabled = true,
                    element = "repl",
                    -- icons = {
                    --     pause = "ε½æ",
                    --     play = "ε½ô",
                    --     step_into = "ε½ö",
                    --     step_over = "ε½û ",
                    --     step_out = "ε½ò",
                    --     step_back = "ε«Å ",
                    --     run_last = "ε¼╖ ",
                    --     terminate = "ε½ù ",
                    -- },
                },
                floating = {
                    max_height = 0.9,
                    max_width = 0.5,
                    border = vim.g.border_chars,
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
            },
            config = function(_, opts)
                -- local icons = require("core.icons").dap
                -- for name, sign in pairs(icons) do
                --     ---@diagnostic disable-next-line: cast-local-type
                --     sign = type(sign) == "table" and sign or { sign }
                --     vim.fn.sign_define("Dap" .. name, { text = sign[1] })
                -- end
                require("dapui").setup(opts)
            end,
        },

        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle {}
                end,
                desc = "Dap UI",
            },
            {
                "<leader>de",
                function()
                    require("dapui").eval()
                end,
                desc = "Eval",
                mode = { "n", "v" },
            },
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "nvim-neotest/nvim-nio",
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup {
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                clear_on_continue = false,
                virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol",
            }
        end,
    },
    {
        "hedyhli/outline.nvim",
        lazy = false,
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

            require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
            }
        end,
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            -- add any options here
        },
    },
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "clangd",
                "codelldb",
            },
        },
    },

    {
        "mfussenegger/nvim-dap",
        config = function(_, _)
            local dap = require "dap"
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" },
            }
            dap.configurations.cpp = {
                {
                    name = "Tsunami-cpp",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return "./tsunami"
                        -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            -- dap.configurations.python = {
            --     {
            --         type = "python",
            --         request = "launch",
            --         name = "Launch file",
            --         program = "${file}",
            --         pythonPath = function()
            --             return "/usr/bin/python"
            --         end,
            --     },
            -- }
        end,
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "cpp",
                "python",
            },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "folke/neodev.nvim",
        opts = {},
        lazy = false,
    },
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {
            keys = "etovxqpdygfblzhckisuran",
        },
    },
}
