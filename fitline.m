%% Define an affine function (a.k.a. a line) in parametrised form.

function f = fitline(params,x)
  
  a0 = params(1);
  a1 = params(2);
  
  f = a0 + a1*x;
  
end
