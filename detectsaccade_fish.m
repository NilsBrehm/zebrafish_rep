%% In the eye position data, look for sudden movements a.k.a. saccades.

function [saccadetime, fitparams] = detectsaccade_fish(timestamp,eyeposition,dataset,fish, wannafigs, side)
% Median Filter
eyeposition = medfilt1(eyeposition, 8);

% How large a change of eye position should be considered a saccade?
% Find the times at which these saccades occur.
threshold = 2;
index = abs(diff(eyeposition)) > threshold;
saccadetime = timestamp(index);
% Fig Name ermitteln
dataset_str = num2str(dataset);
fishNr = num2str(fish(1,1));
figname = ['Dataset_', dataset_str, '_FishNR_', fishNr, '_Augenseite_', side];

% We have to make sure we don't count the same (prolonged) saccade twice.
% Remove these apparent, but meaningless, additional saccade times.
exclusiontime = 2.0;
fakesaccades = 1 + find(diff(saccadetime) < exclusiontime);
saccadetime(fakesaccades) = [];
if isempty(saccadetime)
    fitparams = [0 0];
    return;  
%     error('Es gab keine Saccaden in dieser Phase')
end

% Fit berechnen, um Saccaden in falsche Richtung auszusortieren
[~,~,fitparams] = fitinterval_all(timestamp,eyeposition,saccadetime, figname,0);
% Alle SacadeTimes mit positiver Steigung weiter geben
index_correct_sac = fitparams(:,2) > 0;
saccadetime = saccadetime(index_correct_sac);
zwischen_params1 = fitparams(:,1);
zwischen_params2 = fitparams(:,2);
fitparams1 = zwischen_params1(index_correct_sac);
fitparams2 = zwischen_params2(index_correct_sac);
fitparams = [fitparams1, fitparams2];


% Finally, plot detected saccade times for visual inspection.
if wannafigs == 1
figure(); 
clf
set(gcf,'Color',[1 1 1],'Position',[10 10 1200 300], 'Name', figname)
axes('Position',[.04 .15 .94 .8])
hold on
plot(timestamp([1 end]),[0 0],'-k')
plot(timestamp,eyeposition,'Color',[.2 .4 .8])
yrange = get(gca,'YLim');
for k = 1:numel(saccadetime)
    plot(saccadetime(k)*[1 1],yrange,'--','Color',[.8 .0 .0])
end
hold off
set(gca,'XLim',timestamp([1 end]),'TickLength',[0 0])
xlabel('time since trial onset  (sec)')
ylabel('eye position  (degrees)')
box on

    % Abbildung speichern
     abb_name = ['figures/', figname];
     print(abb_name, '-dpng')
end

% Fit berechnen, um Saccaden in falsche Richtung auszusortieren
[~,~,fitparams] = fitinterval_all(timestamp,eyeposition,saccadetime, figname, 0);
% Alle SacadeTimes mit positiver Steigung weiter geben und in Fig
% reinploten
if isempty(saccadetime)
    fitparams = [0 0];
    return;  
%     error('Es gab keine Saccaden in dieser Phase')
end
index_correct_sac = fitparams(:,2) > 0;
saccadetime = saccadetime(index_correct_sac);
zwischen_params1 = fitparams(:,1);
zwischen_params2 = fitparams(:,2);
fitparams1 = zwischen_params1(index_correct_sac);
fitparams2 = zwischen_params2(index_correct_sac);
fitparams = [fitparams1, fitparams2];

end




