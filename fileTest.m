

filepath = 'data/GenreClassData_30s.txt';

file = fopen(filepath,'r');
firstLine = fgetl(file);
words = textscan(firstLine,'%s');
fclose(file);

allFeatures = words{1}(4:end-3)';
bestFeature = allFeatures(1);
disp('Best feature was ' + string(bestFeature(1)));

