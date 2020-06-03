function Results3=ReviseFct3(Training,Target,CaseCBRTestPrime)
    %SVM Regression
    Mdl4 = fitrsvm(Training,Target)
    [Results3] = predict(Mdl4,CaseCBRTestPrime);
   