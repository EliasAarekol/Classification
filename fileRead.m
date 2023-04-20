clc; close all; clear;

filepath = 'data/GenreClassData_30s.txt';

% data = extractFileText(filepath);

file = fopen(filepath);
M = readmatrix(filepath);
trainingSize = 792;
srm = M(1:trainingSize,11);
mf1m = M(1:trainingSize,42);
spm = M(1:trainingSize,7);
tempo = M(1:trainingSize,41);
classes = M(1:trainingSize,end-2)';


training = [classes;srm' ; mf1m' ; spm' ; tempo'];

srm = M(trainingSize+1:end,11);
mf1m = M(trainingSize+1:end,42);
spm = M(trainingSize+1:end,7);
tempo = M(trainingSize+1:end,41);
classes = M(trainingSize+1:end,end-2)';


nclasses = 10;



test = [classes ;srm' ; mf1m' ; spm' ; tempo'];

conm = zeros(nclasses);

k = 5;
for n = 1:size(test,2)
    class = kNNClassifier(k,test(2:end,n),training,nclasses);
    conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
end

corrate = trace(conm)/size(test,2);
errate = 1 - corrate;
%class = kNNClassifier(5,test(:,end-2),training,10);





%Histograms
srm = M(1:trainingSize,11);
mf1m = M(1:trainingSize,42);
spm = M(1:trainingSize,7);
tempo = M(1:trainingSize,41);


popsrm = srm(1:80);
metalsrm = srm(81:160);
discosrm = srm(161:239);
classicalsrm = srm(400:478);

subplot(2,2,1);
histogram(popsrm,15);
legend('pop');
hold on;
histogram(metalsrm,15);
histogram(discosrm,15);
histogram(classicalsrm,15);
title('srm');
hold off



srm = spm;
popsrm = srm(1:80);
metalsrm = srm(81:160);
discosrm = srm(161:239);
classicalsrm = srm(400:478);

subplot(2,2,2);
histogram(popsrm,15);
legend('pop');
hold on;
histogram(metalsrm,15);
histogram(discosrm,15);
histogram(classicalsrm,15);
title('spm');

hold off



srm = mf1m;
popsrm = srm(1:80);
metalsrm = srm(81:160);
discosrm = srm(161:239);
classicalsrm = srm(400:478);
subplot(2,2,3);
histogram(popsrm,15);
legend('pop');
hold on;
histogram(metalsrm,15);
histogram(discosrm,15);
histogram(classicalsrm,15);
title('mf1m');

hold off



srm = tempo;
popsrm = srm(1:80);
metalsrm = srm(81:160);
discosrm = srm(161:239);
classicalsrm = srm(400:478);

subplot(2,2,4);
histogram(popsrm,15);
legend('pop');
hold on;
histogram(metalsrm,15);
histogram(discosrm,15);
histogram(classicalsrm,15);
title('tempo');

hold off

srm = M(1:trainingSize,11);
mf1m = M(1:trainingSize,42);
spm = M(1:trainingSize,7);
tempo = M(1:trainingSize,41);
classes = M(1:trainingSize,end-2)';


training = [classes;srm' ; mf1m' ; spm'];

srm = M(trainingSize+1:end,11);
mf1m = M(trainingSize+1:end,42);
spm = M(trainingSize+1:end,7);
tempo = M(trainingSize+1:end,41);
classes = M(trainingSize+1:end,end-2)';


nclasses = 10;



test = [classes ;srm' ; mf1m' ; spm'];

conm2 = zeros(nclasses);

% Tempo removed gives best error rate

k = 5;
for n = 1:size(test,2)
    class = kNNClassifier(k,test(2:end,n),training,nclasses);
    conm2(test(1,n)+1,class+1) = conm2(test(1,n)+1,class+1) +1;
end

corrate = trace(conm2)/size(test,2);
errate2 = 1 - corrate;

errors = zeros(1,62);
errors(11-2) = 5;
errors(42-2) = 5;
errors(7-2) = 5;


% for n = 3:65 
%     
%     if n == 11 || n == 42 || n == 7
%         continue
%     end
%     
%     srm = M(1:trainingSize,11);
%     mf1m = M(1:trainingSize,42);
%     spm = M(1:trainingSize,7);
%     classes = M(1:trainingSize,end-2)';
%     
%     features = M(1:trainingSize,n);
%     
%     training = [classes;srm' ; mf1m' ; spm'; features'];
%     
%     srm = M(trainingSize+1:end,11);
%     mf1m = M(trainingSize+1:end,42);
%     spm = M(trainingSize+1:end,7);
%     classes = M(trainingSize+1:end,end-2)';
% 
%     
%     features = M(trainingSize+1:end,n);
% 
%     test = [classes ;srm' ; mf1m' ; spm';features'];
%     
%     conm3 = zeros(nclasses);
% 
%     
%     for i = 1:size(test,2)
%         class = kNNClassifier(k,test(2:end,i),training,nclasses);
%         conm3(test(1,i)+1,class+1) = conm3(test(1,i)+1,class+1) +1; 
%     end
%     corr = trace(conm3)/size(test,2);
%     errors(n-2) = 1-corr;
%     
% end


% feature num 12 was best

[min,I] = min(errors);


srv = M(1:trainingSize,12);
% 
% srm = srv;
% popsrm = srm(1:80);
% metalsrm = srm(81:160);
% discosrm = srm(161:239);
% classicalsrm = srm(400:478);
% 
% legend();
% hold on;
% histogram(metalsrm,15);
% histogram(discosrm,15);
% histogram(classicalsrm,15);
% histogram(popsrm,15);
% title('srv');
% 
% hold off

% So chose not tempo and spectral rolloff variance

% generate new confusion matrix and error rate


