clc; close all; clear;

% Import dataset
filepath = 'data/GenreClassData_30s.txt';
M = readmatrix(filepath);

features = [11 42 7 6];
trainingSize = 792;
testSize = 990-trainingSize;
classLoc = size(M,2)-2;
nclasses = 10;
totalFeatures = 65;
nfeatures = 4;
models = {};
k = 1;
featureMatrix = zeros(90,nfeatures);
iters = 1;
song = 1;
for n = 1:10
    while M(song,classLoc) == n-1
        for i = features
            featureMatrix(iters,find(features==i)) = M(song,i);
        end
        iters = iters+1;
        song = song +1;
    end
    model = fitgmdist(featureMatrix(1:iters,:),k,'RegularizationValue',0.01);
    models{n} = model;
    featureMatrix = zeros(90,nfeatures);
    iters = 1;
end

test = genTestData(M,classLoc,features,trainingSize+1);


conm = zeros(nclasses);
for n = 1:size(test,2)
    class = f(models,test(2:end,n));
    conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
end

corrate = trace(conm)/testSize;
errate = 1-corrate;

function class = f(models,test)

    probs = zeros(2,size(models,2));
    probs(1,:) = 0:size(models,2)-1;

    for n = 1:size(models,2)
        model = models{n};
        for i = 1:1
            probs(2,n) = probs(2,n) + model.ComponentProportion(i)*mvnpdf(test,model.mu(i,:)',model.Sigma(:,:,i));
        end
    end

    probs = sortrows(probs',2)';
    probs = flip(probs,2);
    class = probs(1,1);

end
% shit performance, verdt å teste.

