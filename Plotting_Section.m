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
%               Gain        = eye velocity / stimulus velocity

% Velo gegen TempFreq -----------------------------------------------------
temp_freq = [0, 1.41, 45, 180, 11.25, 22.5, 90, 5.63, 2.81];
VELO = [M_Velo_AllFish; temp_freq]';
velo_sorted = sort(VELO);
figure(21)
set(gcf,'Color',[1 1 1],'Position',[10 10 1000 500], 'Name', 'Velocity')
subplot(2,1,1)
plot(velo_sorted(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 200 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
subplot(2,1,2)
semilogx(velo_sorted(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
axis([0 300 0 max(velo_sorted(:,1))])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Augengeschwindigkeit [degree/s]')
box off
print('finalfigs/VelocityOverTempFreq', '-dpng')

% Gain gegen TempFreq -----------------------------------------------------
gain = velo_sorted(2:end,1)./velo_sorted(2:end,2); % Phase 1 auslasen, da Stimvelo = 0 !
stim_tempfreq = velo_sorted(2:end,2);
% TempFreq in Velocity umwandeln (fuer Gain)
stim_velo = round(stim_tempfreq / 0.03333, 1);


figure(22)
set(gcf,'Color',[1 1 1],'Position',[10 10 1000 500], 'Name', 'Gain')
subplot(2,1,1)
plot(stim_tempfreq, gain, '-ko', 'LineWidth', 2)
axis([0 200 0 1])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Gain')
box off
subplot(2,1,2)
semilogx(stim_tempfreq, gain, '-ko', 'LineWidth', 2)
axis([0 300 0 1])
set(gca,'TickDir','out', 'LineWidth',1.5)
xlabel('Temporale Frequenz [cycles/s]')
ylabel('Gain')
box off
print('finalfigs/GainOverTempFreq', '-dpng')


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