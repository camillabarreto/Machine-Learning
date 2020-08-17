function actions = map_actions(cars_i, cars_j, max_transfer_absolute)
  %% mapeando as possiveis açoes
  x = min(cars_i, 20-cars_j);
  max_transfer_i = min(x,max_transfer_absolute);
  x = min(cars_j, 20-cars_i);
  max_transfer_j = min(x,max_transfer_absolute);
        
  %% - max_transfer_j,...,0,...,max_transfer_i
  actions = -max_transfer_j:max_transfer_i;
endfunction