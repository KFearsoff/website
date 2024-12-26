# lazy.nvim on NixOS

There are many ways to install plugins to Neovim. Too many. [Perhaps](https://github.com/folke/lazy.nvim)
[even](https://github.com/junegunn/vim-plug) [way](https://github.com/savq/paq-nvim)
[too](https://github.com/wbthomason/packer.nvim) [many](https://github.com/tani/vim-jetpack).

A rather obsessive and probably unhealthy thought that occurs in the minds of Nix
enjoyers all the time states: "Let's Nixify it!"

Not so fast.

Nix is cool enough to be able to do it! It can do it. It does it! In fact, the
default NixOS module supports it, and Home Manager module does too! There's even
a [Neovim distribution](https://github.com/nix-community/nixvim) that is built
around Nix: way to go!

But if you are not a fan of creating your own adventure, you would probably
want to pick up a Neovim distribution. There are 4 really popular ones: [NvChad](https://github.com/NvChad/NvChad),
[LunarVim](https://github.com/LunarVim/LunarVim), [AstroNvim](https://github.com/AstroNvim/AstroNvim),
[LazyVim](https://github.com/LazyVim/LazyVim). What they have in common is... not
using Nix. They use `lazy.nvim` for managing their plugins. Oof.

You could simply do that. You could give up and configure Neovim by yourself. You
could install VS Code. What I chose to do is to bridge `lazy.nvim` with Nix. This
lets you manage the actual packages with Nix, while leveraging `lazy.nvim` for
configuration.

If you are not interested in installing a Neovim distro, `lazy.nvim` still gives
you some cool benefits: lazy loading, managing keymaps in plugin configuration,
ordering dependencies, patching plugin's configuration across the files, profiling.
I mean, it's convenient and provides a lot of high-quality glue. Give it a shot.

## The Setup

Let's start with a fairly basic Neovim installation with Home Manager:

```nix
~home-manager.users.USERNAME = {
home.sessionVariables = {
  EDITOR = "nvim";
};

programs.neovim = {
  enable = true;
  package = pkgs.neovim-nightly;
  vimAlias = true;
  vimdiffAlias = true;
  withNodeJs = true;
};
~};
```

There are a few things we need to do here. First, we need to install `lazy.nvim`
(obviously). It is as easy as it gets. Then, we need to configure `lazy.nvim`
to actually work with Nix. Why doesn't Nix work with `lazy.nvim`, anyway?

So, Neovim has configurable runtime path. `packpath` is a directory for plugins,
and `rtp` is for pretty much everything else. When you install Neovim with Nix,
what you end up using is a Neovim wrapper that sets those options for you, as well
as some others. It's actually quite easy to verify with running Neovim instance:

```shell
$ sudo ps aux | grep neovim
nixchad   562683  1.0  0.0  14404  9216 pts/1    Sl+  19:52   0:00 /etc/profiles/per-user/nixchad/bin/vim --cmd lua vim.g.node_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-node';vim.g.loaded_perl_provider=0;vim.g.loaded_python_provider=0;vim.g.python3_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-python3';vim.g.ruby_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-ruby' --cmd set packpath^=/nix/store/gsmxf7mwhmqq58rn00mzykry1vbx8p7r-vim-pack-dir --cmd set rtp^=/nix/store/gsmxf7mwhmqq58rn00mzykry1vbx8p7r-vim-pack-dir src/lazynvim-nixos.md
nixchad   562686 29.0  0.2 143168 39148 ?        Ssl  19:52   0:00 /etc/profiles/per-user/nixchad/bin/vim --embed --cmd lua vim.g.node_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-node';vim.g.loaded_perl_provider=0;vim.g.loaded_python_provider=0;vim.g.python3_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-python3';vim.g.ruby_host_prog='/nix/store/fa1lr28d8mdr5z4b2vqrgzw9cwwqh5kf-neovim-543e025/bin/nvim-ruby' --cmd set packpath^=/nix/store/gsmxf7mwhmqq58rn00mzykry1vbx8p7r-vim-pack-dir --cmd set rtp^=/nix/store/gsmxf7mwhmqq58rn00mzykry1vbx8p7r-vim-pack-dir src/lazynvim-nixos.md
nixchad   562763  0.0  0.0   6632  2816 pts/5    S+   19:52   0:00 grep neovim
```

And the issue is, `lazy.nvim` resets both `packpath` and `rtp` for... performance.
Yikes. Another thing that `lazy.nvim` does is, well, installing the plugins. Into
a directory that *should* be writable, and it checks for that. And Nix store paths
are not writable, of course. So we need to tell it use our local plugins instead.

Let's do it:

```nix
programs.neovim = {
  plugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];

  extraLuaConfig = ''
    vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
    require("lazy").setup({
      performance = {
        reset_packpath = false,
        rtp = {
            reset = false,
          }
        },
      dev = {
        path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
      },
      install = {
        -- Safeguard in case we forget to install a plugin with Nix
        missing = false,
      },
    })
  '';
};
```

Notice the clever trick we are using. Since configuration of Neovim isn't part
of the package itself, we can make our config depend on the package! Then, we just
point `lazy.nvim` to the `packpath` we get from Nix, and append `/pack/myNeovimPackages/start`
to it to get the directory where our plugins are actually installed.

## Installing Plugins

Let's install a simple plugin for a test. I like to write my Neovim config in separate
lua files to get the full IDE experience: Nix doesn't inject LSP and other cool
stuff into multiline strings, so we don't get syntax highlighting, autocompletions
and all that good stuff.

It's pretty easy to configure, look:

```nix
programs.neovim = {
  extraLuaConfig = ''
~    vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
    require("lazy").setup({
      spec = {
        -- Import plugins from lua/plugins
        { import = "plugins" },
      },
~      performance = {
~        reset_packpath = false,
~        rtp = {
~            reset = false,
~          }
~        },
~      dev = {
~        path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
~      },
~      install = {
~        -- Safeguard in case we forget to install a plugin with Nix
~        missing = false,
~      },
    })
  '';
};

xdg.configFile."nvim/lua" = {
  recursive = true;
  source = ./lua;
};
```

Let's install something! Create `lua/plugins/which-key.lua` file to declare the
plugin:

```lua
return {
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
```

Of course, we need to keep in mind that we need to install the plugin with Nix:

```nix
programs.neovim = {
  plugins = with pkgs.vimPlugins; [
~    lazy-nvim
    which-key-nvim
  ];

  extraLuaConfig = ''
~    vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
    require("lazy").setup({
~      spec = {
~        -- Import plugins from lua/plugins
~        { import = "plugins" },
~      },
~      performance = {
~        reset_packpath = false,
~        rtp = {
~            reset = false,
~          }
~        },
      dev = {
        path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
        patterns = {""}, -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard!
      },
~      install = {
~        -- Safeguard in case we forget to install a plugin with Nix
~        missing = false,
~      },
    })
  '';
};
```

And at this point, you can `git add .` and rebuild your configuration; you should
now have Neovim set up with `lazy.nvim` and `which-key` plugin. Congrats!

```admonish tip
In the last step, we have added `dev.patterns = {""}` line. The empty string functions
as a wild card, as pointed out by [lazy.nvim creator](https://github.com/folke/lazy.nvim/pull/1676#issuecomment-2248942233).
```

## Installing Treesitters

You have two options for installing treesitters. You can install them with Nix,
just keep in mind to ensure that you `nvim-treesitter` config doesn't have any
`ensure_installed` grammars:

```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = false,
      ensure_installed = {},
    },
  },
}
```

You could also just install treesitters with Neovim (just remember to add `gcc`
into `extraPackages`):

```lua
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      parser_install_dir = parser_install_dir,
    },
  },
}
```

There, we basically override the location for compiling treesitters to `~/.cache/nvim/treesitters`.

## Other Incompatibilities

Make sure you don't install [mason.nvim](https://github.com/williamboman/mason.nvim) and [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim).
Reading the intro README tells us all we need to know: mason.nvim is a package manager. We don't want
that! We already have one of our own. The same applies to [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)
and other extensions for mason.nvim - you don't want to install packages with Neovim.

## Examples

As an example, you can check my Neovim config on NixOS!

Config at the time of the writing: <https://github.com/KFearsoff/NixOS-config/tree/088641c3527f1027ebd366a9abb5cc557cd6f0c1/modules/neovim>

Latest config: <https://github.com/KFearsoff/NixOS-config/tree/main/nixosModules/neovim>
