function day_start = day_start(cars, policy)
  day_start = zeros(1,2);
  
  if (policy > 0) %% transfere do LOCAL 1 para o LOCAL 2
    day_start(1) = cars(1) - policy;
    day_start(2) = cars(2) + policy;
  elseif (policy < 0) %% transfere do LOCAL 2 para o LOCAL 1
    day_start(1) = cars(1) + abs(policy);
    day_start(2) = cars(2) + policy;
  endif
  
endfunction