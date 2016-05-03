%% Plot Raw Data
% Plotet Rohdaten aus Eyetracker
% Es muss die Spalte angegeben werden in der die Augenposition fuer das
% linke Auge liegt.
% Danach bitte den Datensatz auswaehlen

function PlotRawData(fishnr, speicherort, data)
% First, we need to select and import some raw eye-tracking data.
% We recommend using 'sampleeyetrack.txt' - or your own data.
% [eye.filename, eye.pathname, ~] = uigetfile('*.txt');
% eye.raw = load([eye.pathname eye.filename]);
% eye.raw = load([pathname filename]);
eye.raw = data;

% Specifically, read out the time stamps and eye positions.
% In doing so, shift time to begin trial at 0 sec.
eye.time     = eye.raw(:,1);
eye.leftpos  = eye.raw(:,fishnr);
eye.rightpos = eye.raw(:,fishnr+1);
eye.time = eye.time - eye.time(1);

% Median Filter
eyeposition_left = medfilt1(eye.leftpos, 10);
eyeposition_right = medfilt1(eye.rightpos, 10);

% Stimulus auslesen
% stim 2
eye.stimphase = eye.raw(:,end);
eye.stimtime = [eye.time, eye.stimphase];


% Then, analyse data as above, but for one stimulus phase at a time.
% For example, analyse only data from stimulus phase no. 5.
eye.stimphasetime = eye.stimtime(eye.stimphase==2,1);

% stim1
eye.stimphasetime1 = eye.stimphasetime - 120;

% Ploten
if fishnr == 5 || fishnr == 7 || fishnr == 9
    genotype = 'BellaDonna';
else
    genotype = 'WT';
end
title_nameLe = [genotype, '-Left Eye'];
title_nameRe = [genotype, '-Right Eye'];
figure(fishnr);
% Linkes Auge
subplot(2,1,1)
plot(eye.time, eyeposition_left)
hold on
plot(eye.stimphasetime(1,1)*[1 1],[min(eyeposition_left) max(eyeposition_left)], '--g')
hold on
plot(eye.stimphasetime(end,1)*[1 1],[min(eyeposition_left) max(eyeposition_left)], '--g')
hold on
plot(eye.stimphasetime1(1,1)*[1 1],[min(eyeposition_left) max(eyeposition_left)], '--g')
hold off
ylabel('Augenposition [Grad]')
title(title_nameLe)
% Rechtes Auge
subplot(2,1,2)
plot(eye.time, eyeposition_right)
hold on
plot(eye.stimphasetime(1,1)*[1 1],[min(eyeposition_right) max(eyeposition_right)], '--g')
hold on
plot(eye.stimphasetime(end,1)*[1 1],[min(eyeposition_right) max(eyeposition_right)], '--g')
hold on
plot(eye.stimphasetime1(1,1)*[1 1],[min(eyeposition_right) max(eyeposition_right)], '--g')
hold off
xlabel('Zeit seit Beginn [s]')
ylabel('Augenposition [Grad]')
title(title_nameRe)

% Fig speichern
figname = num2str(fishnr);
abb_name = ['figs/',speicherort, figname];
print(abb_name, '-dpng')



end