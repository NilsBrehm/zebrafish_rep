%% Along the eye position curve, find intervals you want to fit individually.

function [intervaltime,intervalfit,fitparams] = fitinterval(time,eyeposition,saccadetime)

  % Good criteria for selecting intervals might be the
  % following: (a) one interval per saccade;
  % (b) start at .5 sec after the saccade, and (c1) end 5 sec
  % later - or (c2) end .5 sec before the next saccade, or
  % (c3) at the end of the recording, if either happens sooner.

  intervalnumber = numel(saccadetime);
  intervaltime = cell(intervalnumber,1);
  intervalfit = cell(intervalnumber,1);
  fitparams = cell(intervalnumber,1);

  for k = 1:intervalnumber

    % Define beginning and end of each interval.
    intervalstart = saccadetime(k) + 0.5;
    intervalstop1 = intervalstart + 5.0;
    if k == intervalnumber
      % At last interval, look for end of recording.
      intervalstop2 = time(end);
    else                    
      % At previous intervals, look for next saccade.
      intervalstop2 = saccadetime(k+1) - 0.5;
    end
    % Stop at whichever comes first.
    intervalstop = min(intervalstop1,intervalstop2);
    intervalindex = find(and(time>=intervalstart,time<=intervalstop));
    intervaltime{k} = time(intervalindex);

    % Fit a line to each interval using the function 'computefit' below.
    [intervalfit{k},fitparams{k}] ...
      = computefit(intervaltime{k},eyeposition(intervalindex),'line');
      
    % Finally, plot the fit for each detected interval onto the existing figure.
    figure(21)
    hold on
      plot(intervaltime{k},intervalfit{k},'Color',[.8 .0 .0],'LineWidth',2)    
    hold off

  end

  % Before sending output, convert fit parameters from 'cell'
  % to 'array' format, which will be easier to use. We had only
  % used a cell so far because - depending on the type of function
  % used for fitting - the number of parameters might vary.
  fitparams = cell2mat(fitparams);
    
end
  

  