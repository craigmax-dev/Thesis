% Function to compare results from simulations
function [] = plot_simulationComparisons(plots_simSet, exp_route, ...
  flag_normalise, simulation_set, simulation_set_name)

% TO DO: 
% Normalised plots
% - will be different lengths. Fill in missing data with 0 for obj_fun
% - dividing by 0 will result in NaN - actually want  
              
	% Close any open figures
  close all
  % Create save directory
  if(~exist(exp_route, 'dir'))
    mkdir(exp_route)
  end
  %% Plotting
  % Iterate through each plot in set
  for i = 1:size(plots_simSet,1)
    % Load data information
    data_name = plots_simSet{i,1};
    flag_plot = plots_simSet{i,2};
%     [lab_title, lab_x, lab_y, ~] = func_plot_labels(data_name);
%     lab_legend = {};
    % Variable plots
    if flag_plot
      % Create figure
      f = figure("name", data_name);
      hold on;
      % Iterate through each simulation in set
      for sim = 1:size(simulation_set,1) 
        % Get files
        sim_name = simulation_set{sim, 1};        
        sim_route = strcat(exp_route, ...
                              "\", sim_name, ...
                              "\", sim_name, ".mat");
        data_struct = load(sim_route, data_name, "t_hist");
        % Extract data into data array
        fields = fieldnames(data_struct);
        data = getfield(data_struct, fields{1});
        axis_t = getfield(data_struct, fields{2});
        % Plot each row
        plot(axis_t, data);
  %       lab_legend{sim} = data_set;
      end
      % Normalised variable plots
      if flag_normalise
        % Create figure
        f = figure("name", data_name);
        hold on;
        % Iterate through each simulation in set
        for sim = 1:size(simulation_set,1)
          % Get files
          sim_name = simulation_set{sim, 1};        
          sim_route = strcat(exp_route, ...
                                "\", sim_name, ...
                                "\", sim_name, ".mat");
          data_struct = load(sim_route, data_name, "t_hist");
          % Extract data into data array
          fields = fieldnames(data_struct);
          new_data = getfield(data_struct, fields{1});
          % Append if not same length?
%           if(size(new_data, 1) > size(data, 1))
%             size(new_data)
%             new_data = new_data(1:size(data,1));
%           end
          data(sim, 1:numel(new_data)) = new_data;
          new_axis = getfield(data_struct, fields{2});
          axis_t(sim, 1:numel(new_axis)) = new_axis;
        end
        % Normalise
        data = data./data(1, :);
        % Plot each row
        for sim = 1:size(plots_simSet,1)
%           plot(axis_t(sim, 1:112), data(sim, 1:112));
          semilogy(axis_t(sim, 1:112), data(sim, 1:112));
    %       lab_legend{sim} = data_set;
        end
      end      
    end
  end
  
    % Labels
%     title(lab_title);
%     xlabel(lab_x);
%     ylabel(lab_y);
%     lab_legend_arr = string(lab_legend);
%     legend(lab_legend_arr); 
%     opengl software

%   %% Save figures as .fig and .jpg files
%   fig_list = findobj(allchild(0), "Type", "figure");
%   for iFig = 1:length(fig_list)
%     h_fig = fig_list(iFig); 
%     fig_name   = get(h_fig, "Name");
%     exp_fig = strcat(exp_folder, "\", fig_name);
%     savefig(h_fig, strcat(exp_fig, ".fig"));
%     saveas(h_fig, strcat(exp_fig, ".jpg"));
%   end
  
end

%% Normalised plots

%% FIS plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Plots
% % % fis_param_hist scatter
% 
% % obj_sum_hist
% data_name = ["SC0.1", "SOPAT0.2", "SOPAT0.3"];
% data_t_end = [9340, 6820, 6460];
% 
% h = figure('name','s_obj_hist_comparison');
% hold on;
% grid on;
% xlabel("Time (s)"); 
% ylabel("Objective function sum");
% title("Objective function sum over time comparison");
% 
% for i = 1:length(data)
%   t_v = linspace(0, data_t_end(i), size(data{i},2));
%   plot(t_v, data{i})
% end
% 
% legend(data_name)
% 
% % obj_hist
% data_name = ["SC0.1", "SOPAT0.2", "SOPAT0.3"];
% data_t_end = [9340, 6820, 6460];
% t_v = linspace(0, t_end, ct_v);
% 
% h = figure('name','obj_hist_comparison');
% hold on;
% grid on;
% xlabel("Time (s)"); 
% ylabel("Objective function");
% title("Objective function over time comparison");
% 
% for i = 1:length(data)
%   t_v = linspace(0, data_t_end(i), size(data{i},2));
%   plot(t_v, data{i})
% end
% 
% legend(data_name)