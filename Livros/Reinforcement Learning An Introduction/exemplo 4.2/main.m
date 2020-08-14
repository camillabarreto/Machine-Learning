% EXEMPLO 4.2: Aluguel de carros de Jack

% ALUGUEL: + $10/carrro
% LOCOMOÇÃO: - $2/carrro
% INTERVALOS: dias
% ESTADOS: nº de carros em cada local no fim do dia ( 0 ate 20[max] ) X ( 0 ate 20[max] )
num_states = 21;
% AÇÕES: nº de carros transportados entre os locais a noite +/- ( 0 ate 5[max] )


%-----------------| 1 INICIALIZATION |-----------------| 
% LOCAL 1
lambda_s1 = 3; lambda_d1 = 3;
% LOCAL 2
lambda_s2 = 4;  lambda_d2 = 2;
% TAXA DE DESCONTO
gama = 0.9;
% PRECISÃO DA ESTIMATIVA
theta = 0.1;
% FUNÇÃO VALOR
Vs = zeros(num_states,num_states);
% POLITICA: define a qtd de carros que devem ser transp. (positivio: L1->L2 , negativo: L2->L1)
Ps = zeros(num_states,num_states);
%------------------|

policy_stable = false
while (!policy_stable)

  %-----------------| 2 POLICY EVALUATION |-----------------|
  exit = false;
  while (!exit)
    [delta, Vs] = policy_evaluation(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
    if (delta < theta)
      delta
      theta
      exit = true;
    endif
  endwhile
  
  %-----------------| 3 POLICY IMPROVEMENT |-----------------| 
  policy_stable = policy_improvement(Vs, Ps, gama, lambda_s1, lambda_d1, lambda_s2, lambda_d2)
  
endwhile
