function V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d)
  
  V = 0; %% novo valor do estado
  day_start = day_start(cars, policy); %% quantidade de carros no inicio do dia conforme a politica
  cost = -2 * abs(policy); %% custo de transporte de carros
  
  
  %% ESSE CODIGO ESTA GERANDO UM RESULTADO MAIS PROXIMO DO RESULTADO ESPERADO
  %% POREM NAO ESTOU CONTABILIZANDO OS CARROS DEVOLVIDOS, SOMENTE OS ALUGADOS
  
  %% para contabilizar os devolvidos basta mudar o laço de 0:20 
  %% porem o delta no policy_evaluation cresce e o programa nao avança
  
  for day_finale_i = 0:20 %%day_start(1)
    for day_finale_j = 0:20 %%day_start(2)
    
      day_finale = [day_finale_i, day_finale_j]; %% quantidade de carro no fim do dia
      p = zeros(1,2); %% probailidades de aluguel OU devoluçao nos locais
      gain = 0; %% lucro se houver carros alugados
     
      for i = 1:2
        delta = day_finale(i) - day_start(i); %% diferença de carros entre inicio e fim do dia
        if(delta >= 0) %% p/ diferança positiva considera que houve somente devoluçoes
          p(i) = poisspdf(delta, lambda_d(i));
        else %% p/ diferança negativa considera que houve somente alugueis
          p(i) = poisspdf(abs(delta), lambda_r(i)); 
          gain += 10*abs(delta); %% recompensa pelos carros alugados ($10)
        endif
      endfor
      
      finale_state = [day_finale(1) , day_finale(2)] + 1; %% estado final (+1, index(1) = 0 carros)
      reward = gain + cost; %% recompensa
      
      V += (p(1)*p(2))*(reward + (gama*Vs(finale_state(1), finale_state(2))));
      
    endfor
  endfor
    
endfunction