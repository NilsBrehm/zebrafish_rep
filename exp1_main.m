%% Datenanalse der Eyetracker Daten aus Experiment 1
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% USE THIS (Best Version For Now) %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Florian's Skript mit zusaetzlichem MedianFilter und Richtungsselektion
clear
clc
[saccade, interval, fitparams_lefteye] = startanalysishere;


%% Alle Fische einer Platte
clear
clc
le = 5;
re = 6;
for i = 1:6
    le = le+2;
    re = re+2;
[saccade, interval, fitparams_lefteye] = analyse_allFish(le,re);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Einzelne Phase anschauen (AKTUELL! - 26.04.) %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [TF_Protokoll.filename, TF_Protokoll.pathname, ~] = uigetfile('*.txt');
% TF_Protokoll = load([TF_Protokoll.pathname TF_Protokoll.filename]);
% sz = size(TF_Protokoll ,1);
% Protokoll = zeros(sz(1,1), 1);
% for i = 1:sz
%     Protokoll(i,1) = i;
% end

% Alle Datasets aus dem Verzeichnis laden
clear
clc
files = dir('data/*.txt');
alldata = cell(1, numel(files));

% alldata = zeros(1, numel(files));
for i=1:length(files)
%     eval(['load ' files(i).name ' -ascii']);
    alldata{i} = load(files(i).name);
end

%%
% First, we need to select and import some raw eye-tracking data.
% We recommend using 'sampleeyetrack.txt' - or your own data.
% [eye.filename, eye.pathname, ~] = uigetfile('*.txt');
% eye.raw = load([eye.pathname eye.filename]);


% Maximale Anzahl an Datensets ermitteln
max_datasets = numel(alldata);
saccies = cell(1, max_datasets);
fitties = cell(1, max_datasets);

% Alle Datensets durch gehen, und dort jeweils alle Phasen analysieren
for dataset = 1:max_datasets
    % Maximale Anzahl an verschiedenen Stimuli finden
    max_phase = max(alldata{dataset}(:,end));
    % Alle Phasen des Datensatzes analysieren
    for phase_nr = 1:max_phase
        eyedata.raw = alldata{dataset};
        [saccade{phase_nr}, interval{phase_nr}, fitparams_lefteye{phase_nr}] = analyse_phases(phase_nr, eyedata, dataset);
    end
    % Und weil es so schoen ist, nochmal eine Abbildung fuer den ganzen
    % Trial
    [saccadeALL, intervalALL, fitparamsALL] =  analyse_all(eyedata, dataset);
    
    % Saccaden und Fitparams von diesem Datset speichern
    saccies{dataset} = saccade;
    fitties{dataset} = fitparams_lefteye;
    
end
close all;
%%
dataset1_gains = Gains(fitties);
dataset1_gains = dataset1_gains(2,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ----------------------------------------------------------------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Alter Versuch
clear
clc
phase_nr = 5;
[saccade,interval, fitparams_lefteye] = startanalysis_singlePhases(phase_nr);


%% Raw Data ploten
PlotRawData;

%% Anders...
clear
clc
[eye.filename, eye.pathname, ~] = uigetfile('*.txt');
eye.raw = load([eye.pathname eye.filename]);
phase_nr = 5;
[saccade,interval, fitparams] = startanalysis_singlePhases(phase_nr, eye);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

%% Daten laden
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

% %% Plot Raw Daten
% plot(eye.time, eye.leftpos);
% % hold on
% % plot(eye.time, eye.rightpos);
% % hold off

%% Median Filter
eye.leftpos = medfilt1(eye.leftpos,10);

%% Sacaden detektieren
dataset = 0;
threshold = 2;
sac_count = 0;
Diffs = zeros(numel(eye.leftpos-3),1);
for i = 1:1:numel(eye.leftpos)
    
    if i >= numel(eye.leftpos)-3
        break;
    end
    summe_davor = eye.leftpos(i, 1) + eye.leftpos(i+1, 1);
    summe_dahinter = eye.leftpos(i+2, 1) + eye.leftpos(i+3, 1);
    Differenz = summe_dahinter - summe_davor; % Should be positiv, if there is a sacade
    Diffs(i) = Differenz;
    
    if Differenz > threshold
        dataset = dataset+1;
        sac_count = sac_count +1;
        Sac_IDs(dataset,1) = i;
    end
end

sac_times = eye.time(Sac_IDs);

% We have to make sure we don't count the same (prolonged) saccade twice.
% Remove these apparent, but meaningless, additional saccade times.
exclusiontime = 1.0;
fakesaccades = 1 + find(diff(sac_times) < exclusiontime);
sac_times(fakesaccades) = [];

%%
% id = Diffs > threshold;
% Diffs_above = Diffs(id);

%% Alles ploten
yrange = [min(eye.leftpos), max(eye.leftpos)];
plot(eye.time, eye.leftpos)
hold on
plot(sac_times*[1 1], yrange, '--r')

%% Median Filter
MedFilter = medfilt1(eye.leftpos,10);

plot(eye.time, eye.leftpos)
hold on
plot(eye.time, MedFilter, 'r', 'linewidth', 1.5)
legend('Original','Filtered')
legend('boxoff')



%% Tests
%% Sacaden mit falscher Richtung aussortieren

% Alle SacadeTimes mit positiver Steigung weiter geben
index_correct_sac = interval.fitparams(:,2) > 0;
correct_sac_times = saccade.lefteye(index_correct_sac);
correct_interval_fits = interval.fitparams(index_correct_sac);


%% Finally, plot the fit for each detected interval onto the existing figure.
figure(21)
hold on
plot(correct_sac_times*[1 1], [-5 5],'Color',[.0 .0 .8],'LineWidth',2.5)
hold off

Anzahl_Correcter_Saccaden = numel(correct_sac_times);
disp(Anzahl_Correcter_Saccaden)

%%
for dataset = 1:Anzahl_Correcter_Saccaden
    % Finally, plot the fit for each detected interval onto the existing figure.
    figure(21)
    hold on
    plot(intervaltime{dataset},intervalfit{dataset},'Color',[.0 .8 .0],'LineWidth',2)
    hold off
    
end
