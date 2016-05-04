%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ploting Section: Plots analysed eyetracker data
%   - Gain vs. Temporal Frequency
%   - Velocity vs. Temporal Frequency
% 
% Umrechnung: 
%               velocitiy   = grad/s
%               tempfreq    = cycles/s
%               spatfreq    = cycles/grad
%               velocity    = tempfreq / 0.03333
%               tempfreQ    = velocity * 0.03333
%               Gain        = eye velocity / stimulus velocity

% Fertig analysierte Daten laden (aus AlleFischeproDatensatz Skript)
load('Saccaden_Analyse_CompleteWorkspace.mat')

% Velo gegen TempVelo -----------------------------------------------------
temp_freq = [0, 1.41, 45, 180, 11.25, 22.5, 90, 5.63, 2.81];
VELO = [M_Velo_AllFish; temp_freq]';
velo_sorted = sort(VELO);

% Ploten
figure(21)
set(gcf,'Color',[1 1 1],'Position',[10 10 1000 500], 'Name', 'Velocity')
subplot(2,1,1)
plot(velo_sorted(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 200 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Stimulusgeschwindigkeit [degree/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
subplot(2,1,2)
semilogx(velo_sorted(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 300 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Stimulusgeschwindigkeit [degree/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
print('finalfigs/VelocityOverStimVelo', '-dpng')

% Gain gegen TempFreq -----------------------------------------------------
stim_velo = velo_sorted(:,2);
stim_tempfreq = round(stim_velo * 0.03333, 2);
gain = velo_sorted(2:end,1)./stim_velo(2:end,1); % Phase 1 auslasen, da Stimvelo = 0 !

% Ploten
figure(22)
set(gcf,'Color',[1 1 1],'Position',[10 10 1000 500], 'Name', 'Gain')
subplot(2,1,1)
plot(stim_tempfreq(2:end,1), gain, '-ko', 'LineWidth', 2)
axis([0 6 0 1])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Gain')
box off
subplot(2,1,2)
semilogx(stim_tempfreq(2:end,1), gain, '-ko', 'LineWidth', 2)
axis([0 6 0 1])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Gain')
box off
print('finalfigs/GainOverTempFreq', '-dpng')

% Velo gegen TempFreq -----------------------------------------------------
% Ploten
figure(23)
set(gcf,'Color',[1 1 1],'Position',[10 10 1000 500], 'Name', 'Velocity')
subplot(2,1,1)
plot(stim_tempfreq(:,1), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 6 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
subplot(2,1,2)
semilogx(stim_tempfreq(:,1), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 6 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
print('finalfigs/VelocityOverTempFreq', '-dpng')


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