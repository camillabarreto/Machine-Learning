function [day_start_i, day_start_j] = day_start(cars, policy)
  day_start_i = day_start_j = 0;
  
  if (policy > 0) %% transfere do LOCAL 1 para o LOCAL 2
    day_start_i = cars(1) - policy;
    day_start_j = cars(2) + policy;
  elseif (policy < 0) %% transfere do LOCAL 2 para o LOCAL 1
    day_start_i = cars(1) + abs(policy);
    day_start_j = cars(2) + policy;
  endif
  
endfunction