function [delta, Vs] = policy_evaluation(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  delta = 0;
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs) %% percorrer os estados [i = L1 , j = L2]
      
      % quantidade de carros no fim do dia (index 1 = 0 carros)
      cars_i = initial_state_i - 1;
      cars_j = initial_state_j - 1;
      
      old_value = Vs(initial_state_i, initial_state_j); %% valor do estado
      
      policy = Ps(initial_state_i, initial_state_j);
      V = sum_value_function(Vs, policy, cars_i, cars_j, gama, lambda_s1, lambda_s2);
      
      Vs(initial_state_i, initial_state_j) = V; %% novo valor do estado
      delta = max(delta, abs(old_value-V));
      
    end
  end
 
end