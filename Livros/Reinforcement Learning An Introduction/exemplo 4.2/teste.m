

%function V = teste(Vs, policy, cars_i, cars_j, gama, lambda_r1, lambda_d1, lambda_r2, lambda_d2, N1, N2)
%  V = 0; %% novo valor do estado
%  
%  %% ação definida pela politica vai mudar o estado
%  [day_started_i, day_started_j] = day_started(cars_i, cars_j, policy);
%
%  for cars_end_i = 0:20 %% percorrer possiveis qtds de carros alugados
%    for cars_end_j = 0:20
%      
%      %% probabilidade de poisson nos locais
%      [pi, pj] = probability_of_transition(cars_i, cars_j, cars_end_i, cars_end_j, lambda_r1, lambda_d1, lambda_r2, lambda_d2, N1, N2)
%      
%      %% recompensa pelos carros alugados ($10)
%      reward = 10*(rental_i + rental_j);
%
%      %% incrementar V
%      finale_state_i = cars_end_i + 1 %% +1 pq index 1  = 0 carros
%      finale_state_j = cars_end_j + 1;
%      V += (pi*pj)*(reward + (gama*Vs(finale_state_i, finale_state_j)));
%      
%    end
%  end
%endfunction