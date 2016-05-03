%% LOAD DATA
% Alle Datasets aus dem Verzeichnis laden
clear
clc
files = dir('belladonna/data/*.txt');
alldata = cell(1, numel(files));

% alldata = zeros(1, numel(files));
for i=1:length(files)
%         eval(['load ' files(i).name ' -ascii']);
    alldata{i} = load(files(i).name);
end
%% ANALYSE
% Maximale Anzahl an Datensets ermitteln
% max_datasets = numel(alldata);
max_datasets = 1;
saccies = cell(1, max_datasets);
fitties = cell(1, max_datasets);

% Alle Datensets durch gehen, und dort jeweils alle Phasen analysieren
for dataset = 1:max_datasets
    % Maximale Anzahl an verschiedenen Stimuli finden
    max_phase = max(alldata{dataset}(:,end));
    % Spalte festlegen
    le = 5;
    re = 6;
    eyedata.raw = alldata{dataset};
    for fish = 1:6
        fish = [le, re];
%         [saccadeALL{fish}, intervalALL{fish}, fitparamsALL{fish}] =  analyse_fish(eyedata, dataset, fish);
        [saccadeLE, fitparamsLE] =  analyse_fish(eyedata, dataset, fish, 1);
        [saccadeRE, fitparamsRE] =  analyse_fish(eyedata, dataset, fish, 2);
        
        le = le+2;
        re = re+2;
        clear fish;
    end
            % Saccaden und Fitparams von diesem Datset speichern
        saccies{dataset} = saccadeALL;
        fitties{dataset} = fitparamsALL;
        
end
close all;

%% Plot Raw Data
fish_nr = 2; % Hier Fische Nummer angeben
fish_spalten = [5, 7, 9, 11, 13, 15];
max_fish = numel(fish_spalten);
% pathname = 'D:\GP 2016\Zebrafische\MatLab Skripte\Dienstag_2604\belladonna\data\';
% filename = '160427_d4_5dpf_2204_AN_belladonnaVSwt_SEMandTEMP_Gelege3_rec1_f1_6.txt';
speicherort = 'd1/';
for datasets = 1:numel(alldata)
    for fish_nr = 1:max_fish
        name = num2str(datasets);
        speicherort = ['dataset',name ,'/'];
        PlotRawData(fish_spalten(fish_nr), speicherort, alldata{datasets})
    end
end
close all;
