clc; close all; clear;

% Import dataset
filepath = 'data/GenreClassData_30s.txt';
M = readmatrix(filepath);

file = fopen(filepath,'r');
firstLine = fgetl(file);
words = textscan(firstLine,'%s');
fclose(file);

allFeatures = string(words{1}(4:end-3))';
classes = ["pop" "metal" "disco" "blues" "reggae" "classical" "rock" "hiphop" "country" "jazz"];

% Define general constants
trainingSize = 792;
testSize = 990-trainingSize;
classLoc = size(M,2)-2;
nclasses = 10;
totalFeatures = 65;
nfeatures = 4;



%% Task 1

training = genTrainingData(M,classLoc,[11 42 7 41],trainingSize);
test = genTestData(M,classLoc,[11 42 7 41],trainingSize+1);

conm = zeros(nclasses);

k = 5;
for n = 1:size(test,2)
    class = kNNClassifie(k,test(2:end,n),training,nclasses);
    conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
end

corrate = trace(conm)/size(test,2);
errate = 1 - corrate;

disp('Confusion matrix:');
disp(conm);
figure;
cm = confusionchart(conm,classes,'RowSummary','row-normalized');
sortClasses(cm,'descending-diagonal');
title('kNN Classifier');
disp('Error rate:');
disp(errate);

disp('Task 1 finished');
disp('press any button to continue');
pause;
close all;

%% Task 2

%Histograms

disp('Now plotting histograms for each feature');
histogramData = genTrainingData(M,classLoc,[11 42 7 41],trainingSize);

srm = histogramData(2,:)';
mf1m = histogramData(3,:)';
spm = histogramData(4,:)';
tempo = histogramData(5,:)';

pop = srm(1:80);
metal = srm(81:160);
disco = srm(161:239);
classical = srm(400:478);

subplot(2,2,1);
hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title('spectral rolloff mean');
hold off
legend;




pop = mf1m(1:80);
metal = mf1m(81:160);
disco = mf1m(161:239);
classical = mf1m(400:478);

subplot(2,2,3);
hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title('mfcc 1 mean');
hold off
legend;

pop = spm(1:80);
metal = spm(81:160);
disco = spm(161:239);
classical = spm(400:478);

subplot(2,2,2);
hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title('spectral centroid mean');
hold off
legend;


pop = tempo(1:80);
metal = tempo(81:160);
disco = tempo(161:239);
classical = tempo(400:478);

subplot(2,2,4);
hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title('tempo');
hold off
legend;


disp('press any button to continue');
pause;
close all;

% Test when removing one feature

features = [11 42 7 41];
featuresString = ["spectral rolloff mean" "mfcc 1 mean" "spectral centroid mean" "tempo"];
k = 5;

lowestErr = inf;
lowestErrIndex = 1;

for i = 1:4
    
    currentFeats = features;
    currentFeats(i) = [];
    
    training = genTrainingData(M,classLoc,currentFeats,trainingSize);
    test = genTestData(M,classLoc,currentFeats,trainingSize+1);
    
    conm = zeros(nclasses);
    for n = 1:size(test,2)
        class = kNNClassifie(k,test(2:end,n),training,nclasses);
        conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
    end

    corrate = trace(conm)/size(test,2);
    errate = 1 - corrate;
    
    if errate < lowestErr
        lowestErr = errate;
        lowestErrIndex = i;
    end
    
    
    disp('Removed feature:');
    disp(featuresString(i));
    disp('Confusion matrix:');
    disp(conm);
    disp('Error rate:');
    disp(errate);
    cm = confusionchart(conm,classes,'RowSummary','row-normalized');
    title(featuresString(i) + " removed");
    sortClasses(cm,'descending-diagonal');

    
    disp('press any button to continue');
    pause;
    close all;
    
end

disp('Lowest error rate is:');
disp(lowestErr);
disp('Lowest error rate occured when ' + featuresString(lowestErrIndex) + ' was removed');


disp('Task 2 finished');
disp('press any button to continue');
pause;
%% Task 3

errors = zeros(1,totalFeatures-3);
errors(11-2) = inf;
errors(42-2) = inf;
errors(7-2) = inf;

bestConm = zeros(nclasses);
lowestErr = inf;



bestFeature = allFeatures(1);

for n = 3:totalFeatures 
    
    if n == 11 || n == 42 || n == 7
        continue
    end
    
    features = [11 42 7 n];
    training = genTrainingData(M,classLoc,features,trainingSize);
    test = genTestData(M,classLoc,features,trainingSize+1);

    conm = zeros(nclasses); 
    for i = 1:size(test,2)
        class = kNNClassifie(k,test(2:end,i),training,nclasses);
        conm(test(1,i)+1,class+1) = conm(test(1,i)+1,class+1) +1; 
    end
    corr = trace(conm)/size(test,2);
    errate = 1-corr;
    errors(n-2) = errate;
    
    if errate <lowestErr
        lowestErr = errate;
        bestFeature = allFeatures(n-2);
        bestConm = conm;
    end
    
end

bestFeature = split(bestFeature,'_');


disp('Best feature was ' + bestFeature(1)+ " "  + bestFeature(2));
disp('Best feature had confusion matrix:')
disp(bestConm);
disp('Best feature had error rate:');
disp(lowestErr);
disp('press any button to continue');
cm = confusionchart(bestConm,classes,'RowSummary','row-normalized');
sortClasses(cm,'descending-diagonal');
title(bestFeature(1)+ " "  + bestFeature(2) + " added");
pause;
close all;
[min,I] = min(errors);

I = I+2;

disp('Now plotting histogram for ' + bestFeature);

histogramData = genTrainingData(M,classLoc,[11 42 7 I],trainingSize);


feature = histogramData(5,:)';


pop = feature(1:80);
metal = feature(81:160);
disco = feature(161:239);
classical = feature(400:478);

hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title(bestFeature(1)+ " "  + bestFeature(2));
hold off
legend;


disp('Task 3 finished');
disp('press any button to continue');
pause;
close all;

%% Task 4

features = [11 42 7 6 22];
nfeatures = 5;
featureMatrix = zeros(90,nfeatures);
iters = 1;
song = 1;


class_data = zeros(1+nfeatures+nfeatures^2,nclasses);

for n = 1:10
    while M(song,classLoc) == n-1
        for i = features
            featureMatrix(iters,find(features==i)) = M(song,i);
        end
        iters = iters+1;
        song = song +1;
    end
    
    [covar,mean] = genCovAndMean(featureMatrix(1:iters,:));
    class_data(:,n) = [n-1;mean;reshape(covar,nfeatures^2,1)];
    featureMatrix = zeros(90,nfeatures);
    iters = 1;
end




% Testing
test = genTestData(M,classLoc,features,trainingSize+1);

conm = zeros(nclasses);
for n = 1:size(test,2)
    class = gaussianClassifier(class_data,test(2:end,n),nfeatures);
    conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
end

corrate = trace(conm)/testSize;
errate = 1-corrate;

histogramData = genTrainingData(M,classLoc,[11 42 7 22],trainingSize);


feature = histogramData(5,:)';


pop = feature(1:80);
metal = feature(81:160);
disco = feature(161:239);
classical = feature(400:478);

hold on;
histogram(pop,15);
histogram(metal,15);
histogram(disco,15);
histogram(classical,15);
title('chroma stft 6 mean');
hold off
legend;
close all;


cm = confusionchart(conm,classes,'RowSummary','row-normalized');
sortClasses(cm,'descending-diagonal');
title("plug-in MAP classifier");






