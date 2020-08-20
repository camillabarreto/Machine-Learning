% EXEMPLO 4.2: Aluguel de carros de Jack

%-----------------| 1 INICIALIZATION |-----------------| 
% ALUGUEL, LOCOMOÇÃO
gain = 10; cost = -2;
% MÉDIA DE ALUGUEL , MÉDIA DE DEVOLUÇÃO (L1, L2)
lambda_r = [3, 4]; lambda_d = [3, 2];
% TAXA DE DESCONTO, PRECISÃO DA ESTIMATIVA
gama = 0.9; theta = 0.1;
% ESTADOS: nº de carros em cada local no fim do dia ( 0 ate 20[max] ) X ( 0 ate 20[max] )
num_states = 21;
% AÇÕES: nº de carros transportados entre os locais a noite +/- ( 0 ate 5[max] )
% POLITICA: define a qtd de carros que devem ser transp. (positivio: L1->L2 , negativo: L2->L1)
Ps = zeros(num_states,num_states);
% FUNÇÃO VALOR
Vs = zeros(num_states,num_states);

%------------------|

policy_stable = false;
i = 0
while(i < 3)

%while (!policy_stable)

  %-----------------| 2 POLICY EVALUATION |-----------------|

  exit = false;
  while (!exit)
  
    fprintf('POLICY EVALUATION. Press enter to continue.\n'); pause;
    [delta, Vs] = policy_evaluation(Vs, Ps, gama, lambda_r, lambda_d);
    
    delta
    theta
    
    if (delta < theta) 
      exit = true;
    endif
    
  endwhile

  %-----------------| 3 POLICY IMPROVEMENT |-----------------| 
  
  fprintf('POLICY IMPROVEMENT. Press enter to continue.\n'); pause;
  [policy_stable, Ps] = policy_improvement(Vs, Ps, gama, lambda_r, lambda_d);
  
  Ps
  policy_stable

  i+=1;
endwhile

Ps
Vs