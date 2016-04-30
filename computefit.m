%% Compute the best fit using a specified type of function.
  
function [bestfit,params] = computefit(x,y,type)

  switch type

    case 'line'   % Fit a line to our data, using the function 'fitline' below.
      
      if isempty(x) || isempty(y)
        bestfit = fitline([0 0],x);
        params = [0 0];
      else
        params = nlinfit(x,y,@fitline,[-1 1]);
        bestfit = fitline(params,x);
      end

    case 'expo'   % Fit an exponential function, using the function 'fitexpo' below.
                  % (sign of initial parameters may have to be chosen wisely)

      params = nlinfit(x,y,@fitexpo,[1 1]);
      bestfit = fitexpo(params,x);

    case 'poly'   % In some special cases, fitting a polynomial is a reasonable
                  % choice. In this case, the code required is rather simple.

      polynomialfitorder = 1;
      params = polyfit(x,y,polynomialfitorder);
      bestfit = polyval(params,xdata);
      
  end
  
  %   % Here's a toy dataset just to test the fitting function 'computefit':
  %   xdata = 0:.1:10;
  %   ydata1 = .2 + 10*xdata + 8.7*randn(size(xdata));
  %   ydata2 = .2 + 1*exp((xdata+.3*randn(size(xdata)))/2) + 8.7*randn(size(xdata));
  % 
  %   % Compute the best fit, to a specified type of function.
  %   yfit1 = computefit(xdata,ydata1,'line');
  %   yfit2 = computefit(xdata,ydata2,'expo');
  %   
  %   figure(20)
  %     clf
  %     hold on
  % %     plot(xdata,ydata1,'Color',[.2 .4 .8])
  %     scatter(xdata,ydata1,'x','MarkerEdgeColor',[.2 .4 .8])
  %     plot(xdata,yfit1,'r')
  % %     plot(xdata,ydata2,'Color','k')
  %     scatter(xdata,ydata2,'x','MarkerEdgeColor','g')
  %     plot(xdata,yfit2,'r')
  %     hold off

end






