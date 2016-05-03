% This code allows you to analyse standalone eyetracking data.
% Specifically, you can detect saccades, quantify them, and
% fit functions to short intervals of slow-phase eye movements.


%% main function

function [saccade, fitparams] = analyse_fish(eye, dataset, fish, side)
  
  % First, we need to select and import some raw eye-tracking data.
  % We recommend using 'sampleeyetrack.txt' - or your own data.
%   [eye.filename, eye.pathname, ~] = uigetfile('*.txt');
%   eye.raw = load([eye.pathname eye.filename]);
  
  % Specifically, read out the time stamps and eye positions.
  % In doing so, shift time to begin trial at 0 sec.
  eye.time     = eye.raw(:,1);
  eye.leftpos  = eye.raw(:,fish(1,1));
  eye.rightpos = eye.raw(:,fish(1,2));
  eye.time = eye.time - eye.time(1);
  
  % Jetzt nur eine Stimulus Phase
%   phase = 4;
%   eye.stimphase = eye.raw(:,end);
%   display(unique(eye.stimphase))
%   eye.leftpos = eye.raw(eye.stimphase==phase,6);

 % If so, compute how many there are per minute of recording.
  recordedminutes = (eye.time(end)-eye.time(1)) / 60;

% Detect the time stamps at which saccades occur.
if side == 1 % Left Eye
    [saccade.lefteye, fitparams.lefteye]  = detectsaccade_fish(eye.time,eye.leftpos, dataset, fish, side);
    saccade.leftperminute  = numel(saccade.lefteye)  / recordedminutes;
elseif side == 2 % Right Eye
    [saccade.righteye, fitparams.righteye]  = detectsaccade_fish(eye.time,eye.rightpos, dataset, fish, side);
    saccade.rightperminute  = numel(saccade.righteye)  / recordedminutes;
else
    error('No Eye selected!');
end

  % Are you happy with the automatically detected saccades?
 

    
  % Next, select which part of the data you want to fit a function to.
  % Let us stick to the eye position of the left eye for now, and
  % fit a function to the intervals between saccades of the left eye.

  % Fit berechnen
%   [intervaltime,intervalfit,interval.fitparams] = fitinterval(eye.time,eye.leftpos,saccade.lefteye);  


  % You can use these fits to further analyse slow-phase eye movements.
  % For example, the gain of the slow-phase is equal to its slope.
  % This slope is approximately that of the line fit to the interval.
%   interval.gain = interval.fitparams(:,2);

  
  % Further examples: compare behavioural performance for different
  % contrast levels of the stimulus, different spatial frequencies etc.
  % First, find out which stimulus phases were presented.
%   eye.stimphase = eye.raw(:,end);
%   display(unique(eye.stimphase))
%   
%   % Then, analyse data as above, but for one stimulus phase at a time.
%   % For example, analyse only data from stimulus phase no. 5.
%   eye.leftpos = eye.raw(eye.stimphase==5,6);

  % Now you can perform the analysis for this reduced data set.
  % Can you take it from here?
  
end



