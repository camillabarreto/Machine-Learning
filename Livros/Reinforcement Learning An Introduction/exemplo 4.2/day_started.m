function [day_started_i, day_started_j] = day_started(cars_i, cars_j, policy)
  day_started_i = day_started_j = 0;
  if (policy > 0) %% transfere do LOCAL 1 para o LOCAL 2
    day_started_i = cars_i - policy;
    day_started_j = cars_j + policy;
  elseif (policy < 0) %% transfere do LOCAL 2 para o LOCAL 1
    day_started_i = cars_i + abs(policy);
    day_started_j = cars_j + policy;
  endif
endfunction