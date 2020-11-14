% Function func_plot_labels()
% Return labels for plots  

function [lab_title, lab_x, lab_y, lab_legend, lab_cmap, pos, ylimits] = func_plot_labels(data_name, data_type)
  pos_topLeft = [0.25, 0.8, 0.1, 0.1];
  pos_topRight = [0.7, 0.8, 0.1, 0.1];
  ylimits = [-inf inf];
  ylimits = [-inf 1.05];
  lab_cmap = "";
  if data_name == "m_f_hist_animate"
    lab_title = "";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "";
    pos = pos_topRight;
  elseif data_name == "m_dw_hist_animate"
    lab_title = "";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "";
    pos = pos_topRight;
  elseif data_name == "m_bo"
    lab_title = "";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "Building occupancy";
    lab_cmap = "$$p_{bo}$$";
    pos = pos_topRight;
  elseif data_name == "m_prior"
    lab_title = "";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "Cell priority";
    lab_cmap = "$$p_{prior}$$";
    pos = pos_topRight;
  elseif data_name == "m_f_hist"
    lab_title = "";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "Ignition time (s)";
    lab_cmap = "$$t_{i}$$";
    pos = pos_topRight;
  elseif data_name == "m_scan_hist"
    lab_title = "Scan time (s)";
    lab_x = "Latitude";
    lab_y = "Longitude";
    lab_legend = "Scan time (s)";
    lab_cmap = "$$t_{scan}$$";
    pos = pos_topRight;
  elseif data_name == "obj_hist"
    lab_title = "Objective function over simulation";
    lab_x = "Time (s)";
    lab_y = "$J$";
    lab_legend = "";
    pos = pos_topRight;
  elseif data_name == "s_obj_hist"
    if data_type == "variable"
      lab_y = '$$\sum_{k=0}^{t/dt_s} J $$';
    elseif data_type == "relative"
      lab_y = '$$\frac{\sum_{k=0}^{t/dt_s}J_{n}}{\sum_{k=0}^{t/dt_s}J_{1}}$$';
    end
    lab_title = "Objective function sum over simulation";
    lab_x = '$t(s)$';
    lab_legend = "";
    pos = pos_topLeft;
  else
    lab_title = "";
    lab_x = "";
    lab_y = "";
    lab_legend = "";
    pos = pos_topRight;
  end
end
