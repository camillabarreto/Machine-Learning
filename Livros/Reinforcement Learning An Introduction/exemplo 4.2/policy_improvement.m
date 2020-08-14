function policy_stable = policy_improvement(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  policy_stable = true;
  for state_i = 1:rows(Vs)
    for state_j = 1:columns(Vs)
      old_action = Ps(state_i,state_j);
      
      %% a acao que gerar o maior valor
      %% sera a nova politica do estado
      
      
      actions = zeros(11,1);
      for a = 1:columns(actions) %% variando as açoes
      
        %% -------------------- FATORAR ESSA PARTE DEPOIS
        
        V1 = 0; %% novo valor do estado
        
        %% ação definida pela politica vai mudar o estado
        new_i = new_j = 0;
        policy = a - 6;  %(-5,...,0,...,5)
        
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
        
        %% -------------------- FATORAR ATE AQUI
        
        actions(a,1) = V1;
        
      end
      
      %% vejo qual a açao com maior valor
      [val, pos] = max(actions);
      Ps(state_i, state_j) = actions(pos,1);
      
      if (old_action != Ps(state_i,state_j))
          policy_stable = false;
      end
      
    end
  end
  
endfunction
