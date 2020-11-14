% Function func_plot_colormaps
% Return colourmap for plots

function [cmap, cmap_axis] = func_plot_colormaps(data_name, multiplot)
  if multiplot
    cmap = ["#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#666666"];
    cmap_axis = [];
  elseif data_name == "m_f_hist_animate"
    cmap  = [ 1,   1,   1;    % 0
              0.5, 0.5, 0.5;  % 1
              1,   0.5, 0;    % 2
              1,   0,   0;    % 3
              0,   0,   0];   % 4  
    cmap_axis = [0 4];
  else
    cmap = [];
    cmap_axis = [];
  end
end

