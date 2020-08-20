function [Pi, Pj] = probability_of_transition(start_i, start_j, end_i, end_j, lambda_r1, lambda_d1, lambda_r2, lambda_d2, N1, N2)
  delta_i = end_i - start_i;
  delta_j = end_j - start_j;
  
  %% melhorar esse codigo kk
  
  % LOCAL 1
  % D: devolution, R: rent
  D = R = 0;
  if(delta_i < 0)
    D = 0:end_i;
    R = -delta_i:start_i;
  elseif (delta_i > 0)
    D = delta_i:end_i;
    R = 0:start_i;
  else
    D = 0:end_i;
    R = 0:end_i;
  endif
  
  Pi = 0;
  for i = 1:rows(D)
    prob_D = poisspdf(D(i), lambda_d1);
    prob_R = poisspdf(R(i), lambda_r1);
    Pi += (prob_D*prob_R)/N1;
  endfor
  
  % LOCAL 2
  % D: devolution, R: rent
  D = R = 0;
  if(delta_j < 0)
    D = 0:end_j;
    R = -delta_j:start_j;
  elseif (delta_j > 0)
    D = delta_j:end_j;
    R = 0:start_j;
  else
    D = 0:end_j;
    R = 0:end_j;
  endif
  
  Pj = 0;
  for j = 1:rows(D)
    prob_D = poisspdf(D(j), lambda_d2);
    prob_R = poisspdf(R(j), lambda_r2);
    Pj += (prob_D*prob_R)/N2;
  endfor
  
endfunction