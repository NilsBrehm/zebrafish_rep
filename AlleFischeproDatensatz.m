% This Skript loads raw data from eyetracker and starts analysing:
%   - Saccade Detection (only in CCW)
%   - Calculating eye velocity
%   - Calculating gain
%   - Calculating saccades per minute
% Credits to Florian Dehmelt
% © Nils Brehm (2016)

%% LOAD DATA
% % Alle Datasets aus dem Verzeichnis laden
clear
clc
tic
files = dir('data/AltvsJung/tempfreq/6dpf/*.txt');
alldata = cell(1, numel(files));
for i=1:length(files)
    alldata{i} = load(files(i).name);
end
disp('Daten laden:')
toc

%% Load Cleaned Data
% This loads a cleaned version of the original data (Fish that do shit have
% been kicked out manually beforehand ;D)
% clear
% clc
% cleaned = load('cleaned_data.mat');
% alldata = cleaned.alldata;

%% ANALYSE
% Maximale Anzahl an Datensets ermitteln
tic
max_datasets = numel(alldata);
% max_datasets = 2;
sacALL = cell(1, max_datasets);
fitsALL = cell(1, max_datasets);

for phase = 1:9
    
    % Alle Datensets durch gehen, und dort jeweils alle Phasen analysieren
    for dataset = 1:max_datasets
        % Maximale Anzahl an verschiedenen Stimuli finden
        max_phase = max(alldata{dataset}(:,end));
        % Spalte festlegen
        le = 5;
        re = 6;
        % Simulusphase auslesen
        eyedata.raw = alldata{dataset};
        eyedata.raw = eyedata.raw(eyedata.raw(:,end)==phase,:);
        
        % Wie viele Fische?
        howmanyfish = [25, 27, 29, 31, 33, 35; 1, 2, 3, 4, 5, 6]';
        sz = size(alldata{dataset});
        max_cols = sz(1,2);
        
        for fish_nr = 1:howmanyfish(howmanyfish(:,1) == max_cols,2)
            fish = [le, re];
            [saccades{fish_nr}, fitparams{fish_nr}] =  analyse_fish(eyedata, dataset, fish);
            le = le+2;
            re = re+2;
            clear fish;
        end
        % Saccaden und Fitparams von diesem Datset speichern
        sacALL{dataset} = saccades;
        fitsALL{dataset} = fitparams;
    end
    
    close all;
    
    
    % Gain
    
    % Mittlerer Gain beide Augen pro Fisch
    
    for j_dataset = 1:max_datasets
        % Wie viele Fische?
        sz = size(fitsALL{1,j_dataset});
        max_cols = sz(1,2);
        for k_fish = 1:max_cols
            if isempty(fitsALL{1,j_dataset}{1,k_fish}.lefteye)
                Velo_BothEyes = fitsALL{1,j_dataset}{1,k_fish}.righteye(:,2);
                M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);

            elseif isempty(fitsALL{1,j_dataset}{1,k_fish}.righteye)
                Velo_BothEyes = fitsALL{1,j_dataset}{1,k_fish}.lefteye(:,2);
                M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);
 
            else
                Velo_BothEyes = [fitsALL{1,j_dataset}{1,k_fish}.righteye(:,2); fitsALL{1,j_dataset}{1,k_fish}.lefteye(:,2)];
                M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);
                
                Sac_Mins = [sacALL{1,j_dataset}{1,k_fish}.rightperminute(1,1), sacALL{1,j_dataset}{1,k_fish}.leftperminute(1,1)];
                M_Sac_Mins(k_fish,j_dataset) = mean(Sac_Mins);
            end
        end
    end
    
    % Gain over all Fish
    sz = numel(M_Velo_BothEyes);
    dummy = reshape(M_Velo_BothEyes, sz, 1);
    dummy2 = dummy(dummy~=0);
    VELOS{phase}= dummy2;
    M_Velo_AllFish(:,phase) = mean(dummy2);
    SD_Velo_AllFish(:,phase) = std(dummy2);
    
    ns = dummy2;
    clear dummy
    clear dummy2
    clear sz
    
    % Saccaden pro Minuten over all Fish pro Stimphase
    sz2 = numel(M_Sac_Mins);
    dum = reshape(M_Sac_Mins, sz2, 1);
    SACS_ProPhase{phase} = dum;
    M_Sac_Mins_ALLFish(:, phase) = mean(dum,1);
    SD_Sac_Mins_ALLFish(:, phase) = std(dum);
    clear sz2
    clear dum
    
end


n_fish = numel(ns); % Anzahl an Fischen, die in Datenanalyse eingegangen sind
SEM_Velo_AllFish = SD_Velo_AllFish / sqrt(n_fish);
SEM_Sac_Mins_AllFish = SD_Sac_Mins_ALLFish / sqrt(n_fish);
disp('Daten-Analyse:')
toc