{  pkgs, ... }: let 
  fontName = "FiraMono Nerd Font Mono";
in 
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "chris";
    homeDirectory = "/home/chris";
  };

  home.packages = [
    pkgs.bemenu
    (pkgs.nerdfonts.override { fonts = [ "FiraMono" ]; })
    pkgs.joshuto
    pkgs.pavucontrol
    pkgs.tdesktop
    pkgs.nil
    pkgs.ripgrep
    pkgs.wl-clipboard
    pkgs.bat
    pkgs.brave
    pkgs.calibre
    pkgs.hexchat
    pkgs.sway-contrib.grimshot
    pkgs.cachix
    pkgs.tealdeer
    pkgs.pass
    pkgs.unzip
    pkgs.ledger-live-desktop
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.gpg.enable = true;
  programs.direnv.enable = true;
  programs.librewolf.enable = true;
  programs.zsh.enable = true;
  programs.zellij.enable = true;
  programs.lazygit.enable = true;
  programs.swaylock.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      gcloud.disabled = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Chris Ricketts";
    userEmail = "chris_ricketts@protonmail.com";
  };
  
  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    envFile.source = ./nushell/env.nu;
    package = pkgs.nushellFull;
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "nu";
      font = {
        normal.family = fontName;
        normal.style = "Regular";
        bold.family = fontName;
        bold.style = "Bold";
      };
    };
  };

  programs.helix = {
    enable = true;
    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            checkOnSave = {
              command = "clippy";
            };
          };
        };
      };

      language = [{
        name = "typescript";
        formatter = {
          command = "prettier";
          args = [ "--parser" "typescript" ];
        };
        auto-format = true;
      }];      
    };

    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        auto-save = true;
        idle-timeout = 0;
        bufferline = "multiple";
        line-number = "relative";
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        file-picker = {
          hidden = false;
        };
      };
      keys = {
        normal = {
          C-s = ":w";
          A-space = "code_action";
          D = "kill_to_line_end";
          L = ":buffer-next";
          H = ":buffer-previous";
          C-x = "extend_line_up";
          "]" = {
            a = "code_action";
            A = [ "goto_next_diag" "code_action" ];
          };
          "[" = {
            a = "code_action";
            A = [ "goto_prev_diag" "code_action" ];
          };
          space = {
            space = "goto_last_accessed_file";
            c = ":buffer-close";
            C = ":buffer-close-others";
            q = ":quit";
            "ret" = ":reload";
            l = ":lsp-restart";
          };
        };
        insert = {
          C-s = [ "normal_mode" ":write" ];
          A-space = "code_action";
        };
      };
    };
  };
  
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "bemenu-run -p '❯' -i -l 20 -H 25 --fb '#24273a' --ff '#8bd5ca' --nb '#24273a' --nf '#f4dbd6' --tb '#24273a' --hb '#24273a' --tf '#c6a0f6' --hf '#8aadf4' --nf '#f4dbd6' --af '#f4dbd6' --ab '#24273a'";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      window = {
        hideEdgeBorders = "smart";
      };
      fonts.names = [ fontName ];
      keybindings = {
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+Return" = "exec ${terminal} -o shell.program=zsh";
        "${modifier}+z" = "exec ${terminal} -o shell.program=zellij";
        "${modifier}+Shift+z" = "exec ${terminal} -o shell.program=zellij --layout default";
         "${modifier}+Shift+q" = "kill";
         "${modifier}+d" = "exec ${menu}";
         "${modifier}+Shift+0" = "exec swaylock --color 000000";

         "${modifier}+${left}" = "focus left";
         "${modifier}+${down}" = "focus down";
         "${modifier}+${up}" = "focus up";
         "${modifier}+${right}" = "focus right";

         "${modifier}+Left" = "focus left";
         "${modifier}+Down" = "focus down";
         "${modifier}+Up" = "focus up";
         "${modifier}+Right" = "focus right";

         "${modifier}+Shift+s" = "exec grimshot copy area";

         "${modifier}+Shift+${left}" = "move left";
         "${modifier}+Shift+${down}" = "move down";
         "${modifier}+Shift+${up}" = "move up";
         "${modifier}+Shift+${right}" = "move right";

         "${modifier}+Shift+Left" = "move left";
         "${modifier}+Shift+Down" = "move down";
         "${modifier}+Shift+Up" = "move up";
         "${modifier}+Shift+Right" = "move right";

         "${modifier}+b" = "splith";
         "${modifier}+v" = "splitv";
         "${modifier}+f" = "fullscreen toggle";
         "${modifier}+a" = "focus parent";

         "${modifier}+s" = "layout stacking";
         "${modifier}+w" = "layout tabbed";
         "${modifier}+e" = "layout toggle split";

         "${modifier}+Shift+space" = "floating toggle";
         "${modifier}+space" = "focus mode_toggle";

         "${modifier}+1" = "workspace number 1";
         "${modifier}+2" = "workspace number 2";
         "${modifier}+3" = "workspace number 3";
         "${modifier}+4" = "workspace number 4";
         "${modifier}+5" = "workspace number 5";
         "${modifier}+6" = "workspace number 6";
         "${modifier}+7" = "workspace number 7";
         "${modifier}+8" = "workspace number 8";
         "${modifier}+9" = "workspace number 9";

         "${modifier}+Shift+1" =
           "move container to workspace number 1";
         "${modifier}+Shift+2" =
           "move container to workspace number 2";
         "${modifier}+Shift+3" =
           "move container to workspace number 3";
         "${modifier}+Shift+4" =
           "move container to workspace number 4";
         "${modifier}+Shift+5" =
           "move container to workspace number 5";
         "${modifier}+Shift+6" =
           "move container to workspace number 6";
         "${modifier}+Shift+7" =
           "move container to workspace number 7";
         "${modifier}+Shift+8" =
           "move container to workspace number 8";
         "${modifier}+Shift+9" =
           "move container to workspace number 9";

         "${modifier}+Shift+minus" = "move scratchpad";
         "${modifier}+minus" = "scratchpad show";

         "${modifier}+Shift+c" = "reload";
         "${modifier}+Shift+e" =
           "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

         "${modifier}+r" = "mode resize";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb";
          xkb_options = "ctrl:nocaps";
        };
      };
      output = {
        "*" = {
          bg = "#000000 solid_color";
        };
      };
      bars = [{
        mode = "dock";
        hiddenState = "hide";
        position = "bottom";
        workspaceButtons = true;
        workspaceNumbers = true;
        statusCommand = "${pkgs.i3status}/bin/i3status";
        fonts = {
          names = [ "Lilex Nerd Font Mono" ];
          size = 8.0;
        };
        trayOutput = "primary";
        colors = {
          background = "#000000";
          statusline = "#ffffff";
          separator = "#666666";
          focusedWorkspace = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
          };
          activeWorkspace = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
          };
          inactiveWorkspace = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
          };
          urgentWorkspace = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
          bindingMode = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
        };
      }];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  services.gnome-keyring.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
