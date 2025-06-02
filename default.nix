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
          set -g default-terminal "xterm-256color"
          set -as terminal-overrides ",xterm-256color:Tc"

          # Set history limit to 10,000 lines. costs 20 MB.
          # set-option -g history-limit 10000

          # Ctrl+Up to enter copy mode
          bind-key -n M-Up copy-mode

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
        '';
        plugins = with pkgs; [
          tmuxPlugins.tmux-powerline
          # tmuxPlugins.vim-tmux-navigator
        ];
      };
    };
  };
}
