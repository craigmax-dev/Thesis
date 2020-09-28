% Simulate UAV fuzzy controller
% Date:     02/06/2020
% Author:   Craig Maxwell

%% Bugs

function  [a_target, fis_data] = pathPlanner( ...
            n_a, a_target, l_queue, ...
            n_x_s, n_y_s, l_x_s, l_x_y, ...
            m_scan, m_t_scan, m_t_dw, m_prior, ...
            fisArray, ...
            a_t_trav, a_t_scan, ...
            ang_w, v_as, v_w, test_fis_sensitivity, fis_data)
  
  % Initialise maps
  m_att        = NaN(n_x_s, n_y_s, n_a);
  m_schedule   = zeros(n_x_s, n_y_s);
  for a=1:n_a
    if ~isnan(a_target(a, 1, 1))
      m_schedule([a_target(a, 1, 1), a_target(a, 2, 1)]) = 1;      
    end
  end
  
  % Assign tasks
	for q = 2:l_queue 
      % Generate t_nextcell_mat      
      [m_t_response] = timeToNextCell(...
        n_x_s, n_y_s, l_x_s, l_x_y, ...
        n_a, a_t_scan, a_t_trav, a_target, q, ...
        ang_w, v_w, v_as, m_t_scan);
    for a=1:n_a
      % Generate attraction map   
      hdl_attcalc = @(scan_state, schedule_state, t_response, prior, t_dw) attCalc (fisArray(a), scan_state, schedule_state, t_response, prior, t_dw);
      m_att(:,:,a) = arrayfun(hdl_attcalc, m_scan, m_schedule, m_t_response(:,:,a), m_prior, m_t_dw);
      % Record fis data
      if test_fis_sensitivity
        for i=1:n_x_s
          for j=1:n_y_s
            fis_data = [fis_data; m_t_response(i,j), m_prior(i,j), m_t_dw(i,j), m_att(i,j)];
          end
        end        
      end
      % Task assignment
      [a_target, m_schedule] = taskAssignment(...
          a, a_target, q, m_att(:,:,a), m_schedule);        
    end
%     %% Check for conflicting targets and reschedule
%     % Determine conflicting targets
%     while size(a_target(:,:,q),1) ~= size(unique(a_target(:,:,q), 'rows'),1)
%       fprintf("Reschedule")
%       for UAV_1=1:n_a
%         for UAV_2=1:n_a
%           if UAV_1 ~= UAV_2
%             UAV_1_target = a_target(UAV_1, :, q);
%             UAV_2_target = a_target(UAV_2, :, q);
%             if isequal(UAV_1_target, UAV_2_target)
%               % Reassign UAV with lower attraction
%               if m_att(UAV_1_target(1), UAV_1_target(2), UAV_1) >=  m_att(UAV_2_target(1), UAV_2_target(2), UAV_2)
%                 % Set attraction negative
%                 m_att(UAV_2_target(1), UAV_2_target(2), UAV_2) = negAtt;
%                 % Task assignment
%                 [a_target, m_schedule] = taskAssignment(...
%                   UAV_2, a_target, q, m_att(:,:,UAV), m_schedule);
%               else
%                 % Set attraction negative
%                 m_att(UAV_1_target(1), UAV_1_target(2), UAV_1) = negAtt;               
%                 % Task assignment
%                 [a_target, m_schedule] = taskAssignment(...
%                   UAV_1, a_target, q, m_att(:,:,UAV), m_schedule);
%               end
%             end
%           end        
%         end
%       end
%     end
  end
end