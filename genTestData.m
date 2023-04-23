function test = genTestData(dataMatrix,classLoc,features,testStart)
    nFeatures = size(features,2);
    test = zeros(nFeatures+1,size(dataMatrix,1)-testStart+1);
    test(1,:) = dataMatrix(testStart:end,classLoc)';
    
    for n = 2:nFeatures+1
        test(n,:) = dataMatrix(testStart:end,features(n-1))';
    end
end