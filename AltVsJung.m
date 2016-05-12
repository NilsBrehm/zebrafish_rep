%% Alt vs. Jung
%           1. Spalte   2.Spalte    3.Spalte    4. Spalte
%           3dpf        4dpf        5dpf        6dpf
% 1. Zeile Mittelwert
% 2. Zeile SD
% 3. Zeile SEM
clear
%%
% -------------------------------------------------------------------------
% Daten laden
load('data/AltvsJung/contrast/3dpf/3dpf_contrast.mat')
% Sakkaden pro Minute
n_fish1 = sum(n_fish);
Sakkaden = cell2mat(SACS_ProPhase);
% Sakkaden = reshape(Sakkaden, numel(Sakkaden), 1);
Sakkaden_1 = Sakkaden;
SakkadenProMinute(1,1) = mean(Sakkaden);
SakkadenProMinute(2,1) = std(Sakkaden);
SakkadenProMinute(3,1) = std(Sakkaden)/sqrt(n_fish1);

% Velocity 
V1 = VELOS;
Velocity(1,1) = mean(VELOS);
Velocity(2,1) = std(VELOS);
Velocity(3,1) = std(VELOS)/sqrt(n_fish1);

% Gain
gains1 = V1/7.5;
Gain(1,1) = mean(gains1);
Gain(2,1) = std(gains1);
Gain(3,1) = std(gains1)/sqrt(n_fish1);

clearvars -except gains1 gains2 gains3 gains4 Gain n_fish1 n_fish2 n_fish3 n_fish4 Velocity SakkadenProMinute V1 V2 V3 V4 Sakkaden_1 Sakkaden_2 Sakkaden_3 Sakkaden_4

% -------------------------------------------------------------------------
% Daten laden
load('data/AltvsJung/contrast/4dpf/4dpf_contrast.mat')
% Sakkaden pro Minute
n_fish2 = sum(n_fish);
Sakkaden = cell2mat(SACS_ProPhase);
% Sakkaden = reshape(Sakkaden, numel(Sakkaden), 1);
Sakkaden_2 = Sakkaden;
SakkadenProMinute(1,2) = mean(Sakkaden);
SakkadenProMinute(2,2) = std(Sakkaden);
SakkadenProMinute(3,2) = std(Sakkaden)/sqrt(n_fish2);

% Velocity 
V2 = VELOS;

Velocity(1,2) = mean(VELOS);
Velocity(2,2) = std(VELOS);
Velocity(3,2) = std(VELOS)/sqrt(n_fish2);

% Gain
gains2 = V2/7.5;
Gain(1,2) = mean(gains2);
Gain(2,2) = std(gains2);
Gain(3,2) = std(gains2)/sqrt(n_fish2);

clearvars -except gains1 gains2 gains3 gains4 Gain n_fish1 n_fish2 n_fish3 n_fish4 Velocity SakkadenProMinute V1 V2 V3 V4 Sakkaden_1 Sakkaden_2 Sakkaden_3 Sakkaden_4

% -------------------------------------------------------------------------
% Daten laden
load('data/AltvsJung/contrast/5dpf/5dpf_contrast.mat')
% Sakkaden pro Minute
n_fish3 = sum(n_fish);
Sakkaden = cell2mat(SACS_ProPhase);
% Sakkaden = reshape(Sakkaden, numel(Sakkaden), 1);
Sakkaden_3 = Sakkaden;
SakkadenProMinute(1,3) = mean(Sakkaden);
SakkadenProMinute(2,3) = std(Sakkaden);
SakkadenProMinute(3,3) = std(Sakkaden)/sqrt(n_fish3);

% Velocity 
V3 = VELOS;

Velocity(1,3) = mean(VELOS);
Velocity(2,3) = std(VELOS);
Velocity(3,3) = std(VELOS)/sqrt(n_fish3);

% Gain
gains3 = V3/7.5;
Gain(1,3) = mean(gains3);
Gain(2,3) = std(gains3);
Gain(3,3) = std(gains3)/sqrt(n_fish3);

clearvars -except gains1 gains2 gains3 gains4 Gain n_fish1 n_fish2 n_fish3 n_fish4 Velocity SakkadenProMinute V1 V2 V3 V4 Sakkaden_1 Sakkaden_2 Sakkaden_3 Sakkaden_4

% -------------------------------------------------------------------------
% Daten laden
load('data/AltvsJung/contrast/6dpf/6dpf_contrast.mat')
% Sakkaden pro Minute
n_fish4 = sum(n_fish);
Sakkaden = cell2mat(SACS_ProPhase);
% Sakkaden = reshape(Sakkaden, numel(Sakkaden), 1);
Sakkaden_4 = Sakkaden;
SakkadenProMinute(1,4) = mean(Sakkaden);
SakkadenProMinute(2,4) = std(Sakkaden);
SakkadenProMinute(3,4) = std(Sakkaden)/sqrt(n_fish4);

% Velocity 
V4 = VELOS;

Velocity(1,4) = mean(VELOS);
Velocity(2,4) = std(VELOS);
Velocity(3,4) = std(VELOS)/sqrt(n_fish4);

% Gain
gains4 = V4/7.5;
Gain(1,4) = mean(gains4);
Gain(2,4) = std(gains4);
Gain(3,4) = std(gains4)/sqrt(n_fish4);

clearvars -except gains1 gains2 gains3 gains4 Gain n_fish1 n_fish2 n_fish3 n_fish4 Velocity SakkadenProMinute V1 V2 V3 V4 Sakkaden_1 Sakkaden_2 Sakkaden_3 Sakkaden_4





%% Ploten

figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Augengeschwindigkeit')
b1 = bar(Velocity(1,:));
set(b1,'FaceColor', [0.6 0.6 0.6])
hold on
errorbar(Velocity(1,:),Velocity(3,:), '.k', 'LineWidth',1.5)
set(gca,'TickDir','out', 'LineWidth',1.5, 'FontSize', 12, 'Color' , [1 1 1 1],...
    'XTickLabel',{'3 dpf', '4 dpf', '5 dpf', '6 dpf'})
xlabel('Alter der Fische')
ylabel('Augengeschwindigkeit [Grad/Sekunde]')
box off
hold off
print('data/AltvsJung/contrast/Velos', '-dpng')

figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Sakkaden pro Minute')
b2 = bar(SakkadenProMinute(1,:));
set(b2,'FaceColor', [0.6 0.6 0.6])
hold on
errorbar(SakkadenProMinute(1,:),SakkadenProMinute(3,:), '.k', 'LineWidth',1.5)
set(gca,'TickDir','out', 'LineWidth',1.5, 'FontSize', 12, 'Color' , [1 1 1 1],...
    'XTickLabel',{'3 dpf', '4 dpf', '5 dpf', '6 dpf'})
xlabel('Alter der Fische')
ylabel('Sakkaden pro Minute')
box off
print('data/AltvsJung/contrast/SakkadenProMinute', '-dpng')
hold off

% Gain ploten
figure()
set(gcf,'Color',[1 1 1],'Units', 'centimeters','Position',[0 0 20 10], 'Name', 'Gain')
b2 = bar(Gain(1,:));
set(b2,'FaceColor', [0.6 0.6 0.6])
hold on
errorbar(Gain(1,:),Gain(3,:), '.k', 'LineWidth',1.5)
set(gca,'TickDir','out', 'LineWidth',1.5, 'FontSize', 12, 'Color' , [1 1 1 1],...
    'XTickLabel',{'3 dpf', '4 dpf', '5 dpf', '6 dpf'})
xlabel('Alter der Fische')
ylabel('Gain')
box off
print('data/AltvsJung/contrast/Gain', '-dpng')
hold off


%% Statistische Tests
%% Sakkaden Pro Minute
% Kruskal-Wallis Test (nichtparametrische ANOVA)
Sak1 = ones(numel(Sakkaden_1),1);
Sak2 = ones(numel(Sakkaden_2),1)*2;
Sak3 = ones(numel(Sakkaden_3),1)*3;
Sak4 = ones(numel(Sakkaden_4),1)*4;
All_Saks =[Sakkaden_1; Sakkaden_2; Sakkaden_3; Sakkaden_4];
Saks_groups = [Sak1; Sak2; Sak3; Sak4];

[p_sacs,tbl_sacs,stats_sacs] = kruskalwallis(All_Saks, Saks_groups);
% MultCompare
c_sacs = multcompare(stats_sacs);

%% Augengeschwindigkeit
% Kruskal-Wallis Test (nichtparametrische ANOVA)
Velo1 = ones(numel(V1),1);
Velo2 = ones(numel(V2),1)*2;
Velo3 = ones(numel(V3),1)*3;
Velo4 = ones(numel(V4),1)*4;
All_Velos =[V1; V2; V3; V4];
velo_groups = [Velo1; Velo2; Velo3; Velo4];

[p_velo,tbl_velo,stats_velo] = kruskalwallis(All_Velos, velo_groups);
% MultCompare
c_velo = multcompare(stats_velo);

%% Gain
% Kruskal-Wallis Test (nichtparametrische ANOVA)
G1 = ones(numel(gains1),1);
G2 = ones(numel(gains2),1)*2;
G3 = ones(numel(gains3),1)*3;
G4 = ones(numel(gains4),1)*4;
All_Gain =[gains1; gains2; gains3; gains4];
gain_groups = [G1; G2; G3; G4];

[p_gain,tbl_gain,stats_gain] = kruskalwallis(All_Gain, gain_groups);
% MultCompare
c_gain = multcompare(stats_gain);
