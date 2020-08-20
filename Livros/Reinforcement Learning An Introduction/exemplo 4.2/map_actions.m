function actions = map_actions(cars, max_transfer_absolute)
  
  max_transfer = zeros(1,2);
  
  %% mapeando as possiveis açoes
  x = min(cars(1), 20-cars(2)); %% carros disponiveis no LOCAL 1 e espaço disponivel no LOCAL 2
  max_transfer(1) = min(x,max_transfer_absolute); %% verifica se qtd de carros menor que tranf. maxima
  
  x = min(cars(2), 20-cars(1));
  max_transfer(2) = min(x,max_transfer_absolute);
        
  %% - max_transfer_j,...,0,...,max_transfer_i
  actions = -max_transfer(2):max_transfer(1);
endfunction