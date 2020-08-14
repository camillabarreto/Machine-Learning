function [delta, Vs] = policy_evaluation(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  delta = 0;
  for state_i = 1:rows(Vs)
    for state_j = 1:columns(Vs) %% percorrer os estados [i = L1 , j = L2]
      
      V0 = Vs(state_i,state_j); %% valor atual do estado
      V1 = 0; %% novo valor do estado
      policy = Ps(state_i,state_j);
      
      %% ação definida pela politica vai mudar o estado
      new_i = new_j = 0;
      if(policy > 0)
        new_i = state_i - policy;
        new_j = state_j + policy;
      elseif  (policy < 0)
        new_i = state_i + abs(policy);
        new_j = state_j + policy;
      endif
      
      for rental_i = 0:new_i %% percorrer possiveis qtds de carros alugados
        for rental_j = 0:new_j
        
          %% FALTA CONSIDERAR A QTD DE CARROS DEVOLVIDOS
          %% estado s': new - rental + return
          %% +1 é pq o state 0 eh o index 1
          s_i = new_i - rental_i + 1 ;
          s_j = new_j - rental_j + 1;
          
          %% probabilidade de poisson LOCAL 1
          pi = poisspdf(rental_i, lambda_s1);
          %% probabilidade de poisson LOCAL 2
          pj = poisspdf(rental_j, lambda_s2);
          
          %% recompensa pelos carros alugados ($10)
          reward = 10*(rental_i + rental_j);

          %% incrementar V1
          V1 += (pi*pj)*(reward + (gama*Vs(s_i, s_j)));
          
        end
      end
      
      Vs(state_i,state_i) = V1;
      delta = max(delta, abs(V0-V1));
      
    end
  end
 
end