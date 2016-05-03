% This code allows you to analyse standalone eyetracking data.
% Specifically, you can detect saccades, quantify them, and
% fit functions to short intervals of slow-phase eye movements.


%% main function

function [saccade, fitparams] = analyse_fish(eye, dataset, fish)

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


% How long was recording?
recordedminutes = (eye.time(end)-eye.time(1)) / 60;

% Detect the time stamps at which saccades occur.
wannafigs = 0; % Figs machen = 1, Keine Figs = 0
[saccade.lefteye, fitparams.lefteye]  = detectsaccade_fish(eye.time,eye.leftpos, dataset, fish, wannafigs,'left');
saccade.leftperminute  = numel(saccade.lefteye)  / recordedminutes;
[saccade.righteye, fitparams.righteye]  = detectsaccade_fish(eye.time,eye.rightpos, dataset, fish, wannafigs, 'right');
saccade.rightperminute  = numel(saccade.righteye)  / recordedminutes;
end



