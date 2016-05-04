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
clear
clc
load('Saccaden_Contrast_Analyse_02.mat')

% Velo gegen Contrast -----------------------------------------------------
contrast = [0, 0.05, 0.4, 1, 0, 0.2, 0.8 0.1]*100;
VELO = [M_Velo_AllFish; contrast]';
SEM = [SEM_Velo_AllFish; contrast]';
velo_sorted = sort(VELO); % Werte der Groesse nach soriteren
SEM_sorted = sort(SEM); % Werte der Groesse nach soriteren

% Ploten Velo gegen Contrast
velo_sorted_log = log10(velo_sorted);
figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs. StimVelo')
plot(velo_sorted(3:end,2), velo_sorted(3:end,1),'-ko', 'LineWidth', 2)
hold on
errorbar(velo_sorted(3:end,2), velo_sorted(3:end,1), SEM_sorted(3:end,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 120], 'ytick', [0:0.5:4],...
    'FontSize', 12, 'Color' , [1 1 1 1], 'xscale', 'log')
xlabel('Kontrast [%]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Augengeschwindigkeit [Grad/Sekunde]', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/VelocityOverContrast_log', '-dpng')
hold off

% Gain gegen Contrast -----------------------------------------------------
stim_velo = 7.5;
gain = velo_sorted(2:end,1)./stim_velo; % Phase 1 auslasen, da Stimvelo = 0 !
gain_SEM = SEM_sorted(2:end,1)./stim_velo;

% Ploten Gain gegen Contrast
figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Velocity vs. StimVelo')
plot(velo_sorted(3:end,2), gain(2:end,1),'-ko', 'LineWidth', 2)
hold on
errorbar(velo_sorted(3:end,2), gain(2:end,1), gain_SEM(2:end,1), 'k.', 'LineWidth',1)
set(gca,'TickDir','out', 'LineWidth',1.5,'xlim',[0 120],'ylim', [0 1], 'ytick', [0:0.2:1],...
    'FontSize', 12, 'Color' , [1 1 1 1], 'xscale', 'log')
xlabel('Kontrast [%]', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('Gain', 'FontSize', 14, 'FontWeight', 'bold')
box off
print('finalfigs/GainOverContrast_log', '-dpng')
hold off