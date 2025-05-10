{ pkgs, inputs, ... }:
{
  config = {
    programs = {
      tmux = {
        enable = true;
        sensibleOnTop = true;
        extraConfig = ''
          bind - split-window -v
          bind | split-window -h
          unbind '"'
          unbind %

          bind h select-pane -L
          bind l select-pane -R
          bind k select-pane -U
          bind j select-pane -D

          # make sure proper shell is used and not the tmux default
          set -g default-command $SHELL

          # Set history limit to 10,000 lines. costs 20 MB.
          # set-option -g history-limit 10000

          ######################
          ### Copy mode ###
          ######################

          # Ctrl+Up to enter copy mode
          bind-key -n C-Up copy-mode

          # Bind PgUp/PgDn for scrolling
          bind PgUp send-keys -X scroll-up
          bind PgDn send-keys -X scroll-down

          # Half-page scroll
          bind C-M-v send-keys -X halfpage-up
          bind C-V send-keys -X halfpage-down

          # Faster line scroll with Shift key
          bind S-Up send-keys -X scroll-up
          bind S-Down send-keys -X scroll-down

          # Don‘t exit copy mode after mouse selection
          unbind MouseDragEnd1Pane

          # Copy selection on middle click
          bind-key -T copy-mode MouseDown2Pane send-keys -X copy-pipe-and-cancel "pbcopy"

          ######################
          ### DESIGN CHANGES ###
          ######################

          # loud or quiet?
          set -g visual-activity off
          set -g visual-bell off
          set -g visual-silence off
          setw -g monitor-activity off
          set -g bell-action none

          #  modes
          setw -g clock-mode-colour colour5
          setw -g mode-style 'fg=colour1 bg=colour18 bold'

          # panes
          set -g pane-border-style 'bg=default fg=colour8'
          set -g pane-active-border-style 'bg=default fg=colour9'

          # statusbar
          # set -g status-position bottom
          # set -g status-justify left
          # set -g status-style 'bg=colour8 fg=colour255 dim'
          # set -g status-left '''
          # set -g status-right '#[fg=colour255,bg=colour8]#h  #[fg=colour255,bg=colour8] %d/%m #[fg=colour255,bg=colour8] %H:%M:%S '
          # set -g status-right-length 50
          # set -g status-left-length 20

          # setw -g window-status-current-style 'fg=colour1 bg=colour214 bold'
          # setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour22]#W#[fg=colour249]#F '

          # setw -g window-status-style 'fg=colour9 bg=colour18'
          # setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

          # setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

          # # messages
          # set -g message-style 'fg=colour232 bg=colour16 bold'
        '';
        plugins = with pkgs; [
          tmuxPlugins.tmux-powerline
          # tmuxPlugins.vim-tmux-navigator
        ];
      };
    };
  };
}
