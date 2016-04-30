%% Define an exponential function in parametrised form.

function f = fitexpo(params,x)
  
  a = params(1);
  tau = params(2);
  
  f = a*exp(1).^(x/tau);
  
end