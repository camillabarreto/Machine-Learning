function policy_stable = policy_improvement(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  
  policy_stable = true;
  
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs) %% percorrendo os estados
      
      % quantidade de carros no fim do dia (index 1 = 0 carros)
      cars_i = initial_state_i - 1;
      cars_j = initial_state_j - 1;
      
      if(!((cars_i == 0) && (cars_j == 0)))
      
        %% mapeando as possiveis açoes
        max_transfer_absolute = 5;
        actions = map_actions(cars_i, cars_j, max_transfer_absolute);
        actions_values = zeros(size(actions));
        
        for a = 1:columns(actions_values) %% variando as açoes
          
          policy = actions(a); %% adotando a açao como politica desse estado
          V = 0; %% somatorio de valor do estado para a politica adotada
          
          %% politica altera qtd de carros dos locais no inicio do dia
          [cars_i, cars_j] = day_started(cars_i, cars_j, policy);
          
          for rental_i = 0:cars_i %% percorrer possiveis qtds de carros alugados
            for rental_j = 0:cars_j
            
              %% FALTA CONSIDERAR A QTD DE CARROS DEVOLVIDOS
              %% estado s': day_started - rental + return
              finale_state_i = cars_i - rental_i + 1; %% +1, index 1 = 0 carros
              finale_state_j = cars_j - rental_j + 1;
              
              %% probabilidade de poisson nos locais
              pi = poisspdf(rental_i, lambda_s1);
              pj = poisspdf(rental_j, lambda_s2);
              
              %% recompensa pelos carros alugados ($10)
              reward = 10*(rental_i + rental_j);

              %% incrementar V
              V += (pi*pj)*(reward + (gama*Vs(finale_state_i, finale_state_j)));
              
            endfor
          endfor
          
          %% -------------------- FATORAR ATE AQUI
          
          actions_values(1,a) = V;
          
        endfor
        
        old_action = Ps(initial_state_i,initial_state_j);
        [val, pos] = max(actions_values);
        Ps(initial_state_i, initial_state_j) = actions(1,pos);
        if (old_action != Ps(initial_state_i,initial_state_j))
          policy_stable = false;
        end
      
      endif
    endfor
  endfor
  
endfunction
