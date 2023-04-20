clc; close all; clear;

filepath = 'data/GenreClassData_30s.txt';

% data = extractFileText(filepath);

file = fopen(filepath);
M = readmatrix(filepath);
trainingSize = 792;

classLoc = size(M,2)-2;

nfeatures = 4;

feat_locs = [ 11 42 7 12];

features = zeros(90,nfeatures);

n_classes = 10;

A = zeros(90,nfeatures);
iters = 1;
song = 1;


class_data = zeros(1+nfeatures+nfeatures^2,n_classes);

for n = 1:10
    while M(song,classLoc) == n-1
        for i = feat_locs
            disp(size(A,2));
            
            A(iters,find(feat_locs==i)) = M(song,i);
        end
        
        
        iters = iters+1;
        song = song +1;
    end
    
    [covar,mean] = genCovAndMean(A(1:iters,:));
    class_data(:,n) = [n-1;mean;reshape(covar,nfeatures^2,1)];
    A = zeros(90,nfeatures);
    iters = 1;
end


srm = M(trainingSize+1:end,11);
mf1m = M(trainingSize+1:end,42);
spm = M(trainingSize+1:end,7);
spr = M(trainingSize+1:end,12);
classes = M(trainingSize+1:end,end-2)';

test = [classes ;srm' ; mf1m' ; spm' ; spr'];

% Testing


k = 5;
conm = zeros(n_classes);

for n = 1:size(test,2)
    class = gaussianClassifier(class_data,test(2:end,n),nfeatures);
    conm(test(1,n)+1,class+1) = conm(test(1,n)+1,class+1) +1;
end



