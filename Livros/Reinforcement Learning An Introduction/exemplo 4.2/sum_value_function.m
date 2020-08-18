function V = sum_value_function(Vs, policy, cars_i, cars_j, gama, lambda_s1, lambda_s2)
  V = 0; %% novo valor do estado
  
  %% ação definida pela politica vai mudar o estado
  [day_started_i, day_started_j] = day_started(cars_i, cars_j, policy);

  for rental_i = 0:day_started_i %% percorrer possiveis qtds de carros alugados
    for rental_j = 0:day_started_j
    
      %% FALTA CONSIDERAR A QTD DE CARROS DEVOLVIDOS
      %% estado s': new - rental + return
      finale_state_i = day_started_i - rental_i + 1 ;  %% +1, index 1 = 0 carros
      finale_state_j = day_started_j - rental_j + 1;
      
      %% probabilidade de poisson nos locais
      pi = poisspdf(rental_i, lambda_s1);
      pj = poisspdf(rental_j, lambda_s2);
      
      %% recompensa pelos carros alugados ($10)
      reward = 10*(rental_i + rental_j);

      %% incrementar V
      V += (pi*pj)*(reward + (gama*Vs(finale_state_i, finale_state_j)));
      
    end
  end
endfunction