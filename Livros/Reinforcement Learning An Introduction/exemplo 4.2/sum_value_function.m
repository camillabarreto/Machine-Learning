function V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d)
  
  V = 0; %% novo valor do estado
  [day_start_i, day_start_j] = day_start(cars, policy); %% quantidade de carros no inicio do dia conforme a politica
  cost = -2 * abs(policy); %% custo de transporte de carros
  
  %% CONTABILIZANDO COMBINAÇOES DE ALUGUEL x DEVOLUÇAO
  
  for day_finale_i = 0:20
    for day_finale_j = 0:20 %% percorrendo estados finais
    
      delta = zeros(1,2);
      delta(1) = day_finale_i - day_start_i;
      delta(2) = day_finale_j - day_start_j;
     
      %% mapeamento das combinaçoes - LOCAL 1
      R1max = day_start_i;
      R1 = max(0,-delta(1));
      
      while (R1<=R1max)
        prob_R1 = poisspdf(R1, lambda_r(1));
        prob_D1 = poisspdf(R1+delta(1), lambda_d(1));
        p1 = prob_D1*prob_R1;
        
        %% mapeamento das combinaçoes - LOCAL 2
        R2max = day_start_j;
        R2 = max(0,-delta(2));

        while (R2<=R2max)
          prob_R2 = poisspdf(R2, lambda_r(2));
          prob_D2 = poisspdf(R2+delta(2), lambda_d(2));
          p2 = prob_D2*prob_R2;
          
          gain = 10*(R1 + R2); %% lucro por carros alugados
          
          finale_state = [day_finale_i , day_finale_j] + 1; %% estado final (+1, index(1) = 0 carros)
          reward = gain + cost; %% recompensa
      
          V += (p1*p2)*(reward + (gama*Vs(finale_state(1), finale_state(2))));
          
          R2++;
        endwhile
        R1++;
      endwhile
      
    endfor %% percorrendo estados finais
  endfor
    
endfunction