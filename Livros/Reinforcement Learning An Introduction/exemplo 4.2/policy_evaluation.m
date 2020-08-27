function [delta, Vs] = policy_evaluation(Vs, Ps, gama, lambda_r, lambda_d)
  delta = 0;
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs) %% percorrer os estados
      
      cars = [initial_state_i, initial_state_j] - 1; %% quantidade de carros nos locais (-1, index(1) = 0 carros)
      
      old_value = Vs(initial_state_i, initial_state_j); %% armazena valor antigo do estado
      
      policy = Ps(initial_state_i, initial_state_j); 
      V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d); %% somatorio das probabilidade
      
      Vs(initial_state_i, initial_state_j) = V; %% atribui novo valor ao estado
      delta = max(delta, abs(old_value-V)); %% armazena a maior diferença nas atualizaçoes
      
    end
  end
endfunction