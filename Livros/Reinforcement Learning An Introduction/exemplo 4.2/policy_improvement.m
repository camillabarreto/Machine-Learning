function [policy_stable, Ps] = policy_improvement(Vs, Ps, gama, lambda_r, lambda_d)
  max_transfer_absolute = 5; %% transferencia maxima de carros entre os locais
  policy_stable = true;
  for initial_state_i = 1:rows(Vs)
    for initial_state_j = 1:columns(Vs) %% percorrer os estados
      
      cars = [initial_state_i, initial_state_j] - 1; %% quantidade de carros nos locais (-1, index(1) = 0 carros)
      
      old_action = Ps(initial_state_i,initial_state_j); %% armazena ação antiga do estado
      
      %% mapeando as possiveis açoes
      actions = map_actions(cars, max_transfer_absolute); %% açoes
      actions_values = zeros(size(actions)); %% armazena o valor do estado gerado por cada açao
      
      for a = 1:columns(actions_values) %% variando as açoes
        
        policy = actions(a); %% adotando a açao como politica desse estado
        V = sum_value_function(Vs, policy, cars, gama, lambda_r, lambda_d); %% somatorio das probabilidade
        actions_values(1,a) = V; %% armazenando o valor do estado gerado pela açao
      
      endfor
      
      [val, pos] = max(actions_values); %% captura a açao gananciosa
      Ps(initial_state_i, initial_state_j) = actions(1,pos) %% atribui esse açao como nova politica do estado
      
      fprintf('atualiza estado (politica)\n');pause;
      
      %% se houver alteraçao em pelo menos um estado, a politica esta instavel
      if (old_action != Ps(initial_state_i,initial_state_j)) 
        policy_stable = false;
      end
      
    endfor
  endfor
  
endfunction
