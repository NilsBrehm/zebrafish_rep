%% In the eye position data, look for sudden movements a.k.a. saccades.

function [saccadetime, fitparams] = detectsaccade_phases(timestamp,eyeposition,phase_nr,dataset)
% Median Filter
eyeposition = medfilt1(eyeposition, 20);

% How large a change of eye position should be considered a saccade?
% Find the times at which these saccades occur.
threshold = 2;
index = abs(diff(eyeposition)) > threshold;
saccadetime = timestamp(index);


% -------------ALT------------------------------------
% Sacaden in die falsche Richtung rausschmeissen
% d = diff(eyeposition);
% index2 = d > 0;
% negative_slope = timestamp(index2);
% k = 0;
% for j = 1:numel(saccadetime)
%     id = find(negative_slope == saccadetime(j));
%     id_empty = isempty (id);
%     if id_empty == 1
%         continue
%     end
%
%     %       id = negative_slope == saccadetime(j);
%     k = k+1;
%     sac_time(k) = negative_slope(id);
%     leer = isempty (sac_time(k));
%     if leer == 1
%         sac_time(k) = 'NaN';
%     end
% end
% saccadetime = sac_time;
% ----------------------------------------------------

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
% Fig Name ermitteln
dataset_str = num2str(dataset);
phase_str = num2str(phase_nr);
figname = ['Dataset_', dataset_str, '_mit_Phase_', phase_str];

% Ersten Fit machen, um Saccaden zu finden (wannaplot = 0)
[~,~,fitparams] = fitinterval_phases(timestamp,eyeposition,saccadetime,figname,0);
% Alle SacadeTimes mit positiver Steigung weiter geben
index_correct_sac = fitparams(:,2) > 0;
saccadetime = saccadetime(index_correct_sac);
% zwischen_params1 = fitparams(:,1);
% zwischen_params2 = fitparams(:,2);
% fitparams1 = zwischen_params1(index_correct_sac);
% fitparams2 = zwischen_params2(index_correct_sac);
% fitparams = [fitparams1, fitparams2];



% Finally, plot detected saccade times for visual inspection.

figure(); 
clf
set(gcf,'Color',[1 1 1],'Position',[10 10 1200 300], 'Name', figname)
% set(gcf,'Color',[1 1 1],'Position',[10 10 1200 300],'Name','Eye position')
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

% Fit berechnen, um Saccaden in falsche Richtung auszusortieren
[~,~,fitparams] = fitinterval_phases(timestamp,eyeposition,saccadetime,figname,1);
% Alle SacadeTimes mit positiver Steigung weiter geben und in Fig
% reinploten

if isempty(fitparams)
    return;
%     error('Fehler OOHHHH');
end
index_correct_sac = fitparams(:,2) > 0;
saccadetime = saccadetime(index_correct_sac);
zwischen_params1 = fitparams(:,1);
zwischen_params2 = fitparams(:,2);
fitparams1 = zwischen_params1(index_correct_sac);
fitparams2 = zwischen_params2(index_correct_sac);
fitparams = [fitparams1, fitparams2];

end




