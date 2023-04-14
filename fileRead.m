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

test = [srm' ; mf1m' ; spm' ; tempo'];

class = kNNClassifier(5,test(:,end),training,10);

