function V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d)
  
  V = 0; %% novo valor do estado
  day_start = day_start(cars, policy);
  cost = -2 * abs(policy);
  
%  for rental_i = 0:day_start(1) %% percorrer possiveis qtds de carros alugados
%    for rental_j = 0:day_start(2)
%    
%      %% FALTA CONSIDERAR A QTD DE CARROS DEVOLVIDOS
%      %% estado s': new - rental + return
%      finale_state_i = day_start(1) - rental_i + 1 ;  %% +1, index 1 = 0 carros
%      finale_state_j = day_start(2) - rental_j + 1;
%      
%      %% probabilidade de poisson nos locais
%      pi = poisspdf(rental_i, lambda_r(1));
%      pj = poisspdf(rental_j, lambda_r(2));
%      
%      %% recompensa pelos carros alugados ($10)
%      reward = 10*(rental_i + rental_j);
%
%      %% incrementar V
%      V += (pi*pj)*(reward + (gama*Vs(finale_state_i, finale_state_j)));
%      
%    end
%  end
  
  for day_finale_i = 0:day_start(1)
    for day_finale_j = 0:day_start(2)
    
      day_finale = [day_finale_i, day_finale_j]; 
      p = zeros(1,2);
      gain = 0;
     
      for i = 1:2
        delta = day_finale(i) - day_start(i);
        if(delta >= 0)
          p(i) = poisspdf(delta, lambda_d(i));
        else
          p(i) = poisspdf(abs(delta), lambda_r(i));
          gain += 10*abs(delta); %% recompensa pelos carros alugados ($10)
        endif
      endfor
      
      %% incrementar V
      finale_state = [day_finale(1) , day_finale(2)] + 1; %% index 1 : 0 carros
      reward = gain + cost;
      
      %if((day_finale(1)<=day_start(1))&&(day_finale(2)<=day_start(1)))
        V += (p(1)*p(2))*(reward + (gama*Vs(finale_state(1), finale_state(2))));
      %endif
    endfor
  endfor
  
endfunction