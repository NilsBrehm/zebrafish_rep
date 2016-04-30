% This code allows you to analyse standalone eyetracking data.
% Specifically, you can detect saccades, quantify them, and
% fit functions to short intervals of slow-phase eye movements.


%% main function

function [saccade,interval, fitparams] = startanalysis_singlePhases(phase)

% First, we need to select and import some raw eye-tracking data.
% We recommend using 'sampleeyetrack.txt' - or your own data.
[eye.filename, eye.pathname, ~] = uigetfile('*.txt');
eye.raw = load([eye.pathname eye.filename]);

% Now lets choose the Stimulus Phase
eye.stimphase = eye.raw(:,end);
eye.leftpos = eye.raw(eye.stimphase == phase, 5);
% eye.rightpos = eye.raw(eye.stimphase == phase, 6);

% read out the time stamps for the choosen Stimulus Phase
% In doing so, shift time to begin trial at 0 sec.
id_time = eye.raw(:,end) == phase;
eye.time = eye.raw(id_time, 1);
eye.time = eye.time - eye.time(1);

% Detect the time stamps at which saccades occur.
% [saccade.righteye, fitparams.righteye] = detectsaccade_singlePhase(eye.time,eye.rightpos);
[saccade.lefteye, fitparams.lefteye]  = detectsaccade_singlePhase(eye.time,eye.leftpos);

% Are you happy with the automatically detected saccades?
% If so, compute how many there are per minute of recording.
recordedminutes = (eye.time(end)-eye.time(1)) / 60;
% saccade.rightperminute = numel(saccade.righteye) / recordedminutes;
saccade.leftperminute  = numel(saccade.lefteye)  / recordedminutes;

% Next, select which part of the data you want to fit a function to.
% Let us stick to the eye position of the left eye for now, and
% fit a function to the intervals between saccades of the left eye.

% Fit berechnen
%   [intervaltime,intervalfit,interval.fitparams] = fitinterval(eye.time,eye.leftpos,saccade.lefteye);
interval.Fit = 'No Fit';


% You can use these fits to further analyse slow-phase eye movements.
% For example, the gain of the slow-phase is equal to its slope.
% This slope is approximately that of the line fit to the interval.
fitparams.GainLeftEye = fitparams.lefteye;
% fitparams.GainRightEye = fitparams.rightteye;



end



