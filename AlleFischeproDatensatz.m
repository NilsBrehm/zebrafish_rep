%% LOAD DATA
% % Alle Datasets aus dem Verzeichnis laden
% clear
% clc
% tic
% files = dir('data/temp_freq/*.txt');
% alldata = cell(1, numel(files));
% 
% % alldata = zeros(1, numel(files));
% for i=1:length(files)
% %         eval(['load ' files(i).name ' -ascii']);
%     alldata{i} = load(files(i).name);
% end
% disp('Daten laden:')
% toc
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
    sz = size(alldata{dataset});
    max_cols = sz(1,2);
    for k_fish = 1:howmanyfish(howmanyfish(:,1) == max_cols,2)
        if isempty(fitsALL{1,j_dataset}{1,k_fish}.lefteye)
            Velo_BothEyes = fitsALL{1,j_dataset}{1,k_fish}.righteye(:,2);
            M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);
        elseif isempty(fitsALL{1,j_dataset}{1,k_fish}.righteye)
            Velo_BothEyes = fitsALL{1,j_dataset}{1,k_fish}.lefteye(:,2);
            M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);
        else  
        Velo_BothEyes = [fitsALL{1,j_dataset}{1,k_fish}.righteye(:,2); fitsALL{1,j_dataset}{1,k_fish}.lefteye(:,2)];
        M_Velo_BothEyes(k_fish,j_dataset) = mean(Velo_BothEyes);
        end
    end
end

% Gain over all Fish
sz = numel(M_Velo_BothEyes);
dummy = reshape(M_Velo_BothEyes, sz, 1);
M_Velo_AllFish(:,phase) = mean(dummy);

end
disp('Daten-Analyse:')
toc
%% Velo gegen TempFreq
temp_freq = [0, 1.41, 45, 180, 11.25, 22.5, 90, 5.63, 2.81];
VELO = [M_Velo_AllFish; temp_freq]';
velo_sorted = sort(VELO);
plot(velo_sorted(:,2), velo_sorted(:,1))

%% Gain gegen TempFreq
gain = velo_sorted(2:end,1)./velo_sorted(2:end,2); % Phase 1 auslasen, da Stimvelo = 0 !
stim_tempfreq = velo_sorted(2:end,2);
stim_log = log(stim_tempfreq);
subplot(2,1,1)
plot(stim_tempfreq, gain, '-o')
subplot(2,1,2)
plot(stim_log, gain, '-ro')

%%
% %% Plot Raw Data
% fish_nr = 2; % Hier Fische Nummer angeben
% fish_spalten = [5, 7, 9, 11, 13, 15];
% max_fish = numel(fish_spalten);
% % pathname = 'D:\GP 2016\Zebrafische\MatLab Skripte\Dienstag_2604\belladonna\data\';
% % filename = '160427_d4_5dpf_2204_AN_belladonnaVSwt_SEMandTEMP_Gelege3_rec1_f1_6.txt';
% speicherort = 'd1/';
% for datasets = 1:numel(alldata)
%     for fish_nr = 1:max_fish
%         name = num2str(datasets);
%         speicherort = ['dataset',name ,'/'];
%         PlotRawData(fish_spalten(fish_nr), speicherort, alldata{datasets})
%     end
% end
% close all;
