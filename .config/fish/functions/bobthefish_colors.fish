function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'
  __bobthefish_colors default
  set -x color_initial_segment_exit black red --bold
  set -x color_initial_segment_su black green --bold
  set -x color_initial_segment_jobs black blue --bold
  set -x color_initial_segment_private black white --bold

  set -x color_vi_mode_insert grey black
end
