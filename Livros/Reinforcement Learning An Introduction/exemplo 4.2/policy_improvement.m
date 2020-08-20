function [policy_stable, Ps] = policy_improvement(Vs, Ps, gama, lambda_r, lambda_d)
  max_transfer_absolute = 5;
  policy_stable = true;
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs)
      
      cars = [initial_state_i, initial_state_j] - 1; %(index 1 = 0 carros)
      
      old_action = Ps(initial_state_i,initial_state_j);
      
      %% mapeando as possiveis açoes
      actions = map_actions(cars, max_transfer_absolute);
      actions_values = zeros(size(actions));
      
      for a = 1:columns(actions_values) %% variando as açoes
      
        policy = actions(a); %% adotando a açao como politica desse estado
        V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d);
        actions_values(1,a) = V;
      
      endfor
      
      [val, pos] = max(actions_values);
      Ps(initial_state_i, initial_state_j) = actions(1,pos);
      
      if (old_action != Ps(initial_state_i,initial_state_j))
        policy_stable = false;
      end
      
    endfor
  endfor
  
endfunction
