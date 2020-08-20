function [N1, N2] = normalize(lambda_r1, lambda_d1, lambda_r2, lambda_d2)
  N1 = N2 = 0;
  states = 0:20;
  
  for start = states
    for final = states
    
      delta = final - start;
      
      D = R = 0;
      if(delta < 0)
        D = 0:final;
        R = -delta:start;
      elseif (delta > 0)
        D = delta:final;
        R = 0:start;
      else
        D = 0:final;
        R = 0:final;
      endif
      
      for d = 1:columns(D)
        for r = 1:columns(R)
          prob_D1 = poisspdf(D(d), lambda_d1);
          prob_R1 = poisspdf(R(r), lambda_r1);
          N1 += prob_D1*prob_R1;
          
          prob_D2 = poisspdf(D(d), lambda_d2);
          prob_R2 = poisspdf(R(r), lambda_r2);
          N2 += prob_D2*prob_R2;
        endfor
      endfor
      
      
    endfor
  endfor
  
endfunction