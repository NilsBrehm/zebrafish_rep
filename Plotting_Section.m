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
% clear
% clc
% load('Saccaden_Analyse_03.mat')

% Velo gegen StimVelo -----------------------------------------------------
temp_freq = [0, 1.41, 45, 180, 11.25, 22.5, 90, 5.63, 2.81];
VELO = [M_Velo_AllFish; temp_freq]';
SEM = [SEM_Velo_AllFish; temp_freq]';
velo_sorted = sort(VELO); % Werte der Groesse nach soriteren
SEM_sorted = sort(SEM); % Werte der Groesse nach soriteren

% Ploten
velo_sorted_log = log10(velo_sorted);
figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs. StimVelo')
plot(velo_sorted_log(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
hold on
errorbar(velo_sorted_log(:,2), velo_sorted(:,1), SEM_sorted(:,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 max(velo_sorted_log(:,2))+1], 'ytick', [0:0.5:4], 'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Logarithmus der Stimulusgeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/VelocityOverStimVelo_log', '-dpng')
hold off

figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs log StimVelo')
plot(velo_sorted(:,2), velo_sorted(:,1),'-ko', 'LineWidth', 2)
hold on
errorbar(velo_sorted(:,2), velo_sorted(:,1), SEM_sorted(:,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 200], 'ytick', [0:0.5:4],...
    'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Stimulusgeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/VelocityOverStimVelo', '-dpng')


% Gain gegen TempFreq -----------------------------------------------------
stim_velo = velo_sorted(:,2);
stim_tempfreq = round(stim_velo * 0.03333, 2);
gain = velo_sorted(2:end,1)./stim_velo(2:end,1); % Phase 1 auslasen, da Stimvelo = 0 !
gain_SEM = SEM_sorted(2:end,1)./stim_velo(2:end,1);

% Ploten
figure()
set(gcf,'Color',[1 1 1], 'Units','centimeters' ,'Position',[0 0 20 10], 'Name', 'Gain vs TempFreq')
plot(stim_tempfreq(2:end,1), gain, '-ko', 'LineWidth', 2)
hold on
errorbar(stim_tempfreq(2:end,1), gain, gain_SEM, 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 6], 'xtick', [0:0.5:6],'ylim', [0 1], 'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Temporale Frequenz [Zyklen/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Gain', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/GainOverTempFreq', '-dpng')
hold off

figure()
set(gcf,'Color',[1 1 1], 'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Gain vs TempFreq log')
semilogx(stim_tempfreq(2:end,1), gain, '-ko', 'LineWidth', 2)
hold on
errorbar(stim_tempfreq(2:end,1), gain, gain_SEM, 'k.', 'LineWidth',1)
axis([0 6 0 1])
set(gca,'TickDir','out', 'LineWidth',1.5,'ylim', [0 1],'xlim',[0 6], 'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Temporale Frequenz [Zyklen/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Gain', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/GainOverTempFreq_log', '-dpng')
hold off

% Velo gegen TempFreq -----------------------------------------------------
% Ploten
stim_tempfreq_log = log10(stim_tempfreq);
stim_tempfreq_log(1,1) = 0;
figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs TempFreq')
plot(stim_tempfreq(:,1), velo_sorted(:,1),'-ko', 'LineWidth', 2)
hold on
errorbar(stim_tempfreq(:,1), velo_sorted(:,1), SEM_sorted(:,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 6], 'xtick', [0:0.5:6], 'ytick', [0:0.5:4], 'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Temporale Frequenz [Zyklen/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/VelocityOverTempFreq', '-dpng')

figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs TempFreq')
plot(stim_tempfreq_log(2:end,1), velo_sorted(2:end,1),'-ko', 'LineWidth', 2)
hold on
errorbar(stim_tempfreq_log(2:end,1), velo_sorted(2:end,1), SEM_sorted(2:end,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[min(stim_tempfreq_log)-0.5 max(stim_tempfreq_log)+0.5], 'ytick', [0:0.5:4], 'FontSize', 12, 'Color' , [1 1 1 1])
xlabel('Logarithmus der Temporalen Frequenz [Zyklen/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/VelocityOverTempFreq_log', '-dpng')

% % Sakkend por Minute pro Stimulusphase
% figure()
% set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'SakProMin')
% plot(stim_tempfreq_log(:,1), M_Sac_Mins_ALLFish,'-ko', 'LineWidth', 2)
% hold on
% errorbar(stim_tempfreq_log(:,1), M_Sac_Mins_ALLFish, SEM_Sac_Mins_AllFish, 'k.', 'LineWidth',1)
% set(gca,'TickDir','out', 'LineWidth',1.5,[min(stim_tempfreq) max(stim_tempfreq)], 'ytick', [0:0.5:8], 'FontSize', 12, 'Color' , [1 1 1 1])
% xlabel('Logarithmus der Temporalen Frequenz [Zyklen/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
% ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
% box off
% print('finalfigs/SacsPerMinOverTempFreq_log', '-dpng')



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