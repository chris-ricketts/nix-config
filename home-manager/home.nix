{ inputs, lib, config, pkgs, ... }: {
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
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
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
    pkgs.projectable
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.librewolf.enable = true;
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.zellij.enable = true;
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    userName = "Chris Ricketts";
    userEmail = "chris-ricketts@proton.me";
  };
  
  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    envFile.source = ./nushell/env.nu;
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "nu";
      font = {
        normal.family = "Hack Nerd Font Mono";
        normal.style = "Regular";
        bold.family = "Hack Nerd Font Mono";
        bold.style = "Bold";
        italic.family = "Hack Nerd Font Mono";
        italic.style = "Italic";
        bold_italic.family = "Hack Nerd Font Mono";
        bold_italic.style = "Bold Italic";
      };
    };
  };

  programs.helix = {
    enable = true;
    languages = [{
      name = "rust";
      config = {
        checkOnSave = {
          command = "clippy";
        };
      };
    }];
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
      keybindings = {
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+Return" = "exec ${terminal} -o shell.program=zsh";
        "${modifier}+z" = "exec ${terminal} -o shell.program=zellij";
        "${modifier}+Shift+z" = "exec ${terminal} -o shell.program=zellij --layout default";
         "${modifier}+Shift+q" = "kill";
         "${modifier}+d" = "exec ${menu}";

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
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
