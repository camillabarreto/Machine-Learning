function [policy_stable, Ps] = policy_improvement(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  policy_stable = true;  
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs) %% percorrendo os estados
      
      % quantidade de carros no fim do dia (index 1 = 0 carros)
      cars_i = initial_state_i - 1;
      cars_j = initial_state_j - 1;
      
      old_action = Ps(initial_state_i,initial_state_j);
      
      %% mapeando as possiveis açoes
      max_transfer_absolute = 5;
      actions = map_actions(cars_i, cars_j, max_transfer_absolute);
      actions_values = zeros(size(actions));
      
      for a = 1:columns(actions_values) %% variando as açoes
      
        policy = actions(a); %% adotando a açao como politica desse estado
        V = sum_value_function(Vs, policy, cars_i, cars_j, gama, lambda_s1, lambda_s2);
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
