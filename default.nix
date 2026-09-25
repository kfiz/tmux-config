inputs:
{ pkgs, ... }:
{
  config = {
    programs = {
      tmux = {
        enable = true;
        sensibleOnTop = true;
        keyMode = "vi";
        extraConfig = ''
          bind h split-window -v
          bind v split-window -h
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

          set -g renumber-windows on
          set -g set-clipboard on
          set -g status-position top

          # enter copy mode
          bind Enter copy-mode

          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi C-v send -X rectangle-toggle
          bind -T copy-mode-vi y send -X copy-selection-and-cancel
          bind -T copy-mode-vi Escape send -X cancel
          bind -T copy-mode-vi H send -X start-of-line
          bind -T copy-mode-vi L send -X end-of-line

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
          {
            plugin = inputs.tmux-powerkit.packages.${pkgs.system}.default;
            extraConfig = ''
              set -g @powerkit_plugins "datetime,battery,cpu,memory,hostname"
              set -g @powerkit_theme "solarized"
              set -g @powerkit_theme_variant "dark"
            '';
          }
          tmuxPlugins.yank
          tmuxPlugins.resurrect
          tmuxPlugins.continuum
          # tmuxPlugins.vim-tmux-navigator
        ];
      };
    };
  };
}
