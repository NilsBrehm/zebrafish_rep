%% Daten auswaehlen und laden
clear
clc
[eye.filename, eye.pathname, ~] = uigetfile('*.txt');
eye.raw = load([eye.pathname eye.filename]);

% Specifically, read out the time stamps and eye positions.
% In doing so, shift time to begin trial at 0 sec.
eye.time     = eye.raw(:,1);
eye.leftpos  = eye.raw(:,5);
eye.rightpos = eye.raw(:,6);
eye.time = eye.time - eye.time(1);

%% Median Filter
eye.leftpos_smoothed = medfilt1(eye.leftpos, 10);

%% Find Peaks
findpeaks(eye.leftpos_smoothed,'MinPeakProminence',8)

%% Find Saccades
averaging_step = 10;
sac_count = 0;
sz = size(eye.leftpos_smoothed);
for i = averaging_step+1:(sz(1,1)-averaging_step)
    aktuell = eye.leftpos_smoothed(i,1);
    M_davor = mean(eye.leftpos_smoothed(i-averaging_step:i-1, 1));
    M_danach = mean(eye.leftpos_smoothed(i+1:i+averaging_step, 1));
    if (aktuell > M_davor && aktuell > M_danach) && (M_davor < M_danach)
        sac_count = sac_count + 1;
    end
end

