clear all; close all;
global w CaseCBRTraining;
step=0.1;
alpha=0.4
pourcentageTest=0.25;
%for alpha=0.1:step:0.9
    clear Similarities
    clear Similarities2
    clear CaseCBR2
    clear CaseSim
    clear mat
%%
%%Data loading
    [CaseCBR, Casestxt, Casestab] = xlsread('Data2015to2017.xlsx');
    columnSize=length(CaseCBR(1,:));
    lineSize=length(CaseCBR(:,1));
    n=columnSize-1; %% number of attributes
    nbreTest=pourcentageTest*lineSize;
    CaseCBRTest=CaseCBR(1:nbreTest,:);
    CaseCBRTestPrime=CaseCBR(1:nbreTest,1:n);
    CaseCBRTraining=CaseCBR(nbreTest+1:lineSize,:);
    SolutionExpected=CaseCBRTest(1:nbreTest, columnSize);
    
    %
    %Construct the pairwise comparison matrix.
    w=WeightFct();
    %%
    %New case entry
    %ik=4
    
    RESULTS{1,1}='Cases';
    RESULTS{1,2}='ExpectedSolution';
    RESULTS{1,3}='Pso';
    RESULTS{1,4}='MajorityRule';
    RESULTS{1,5}='ProbabilisticMethod';
    RESULTS{1,6}='ClassBasedMethod';
    RESULTS{1,7}='ErrorPso';
    RESULTS{1,8}='ErrorMajorityRule';
    RESULTS{1,9}='ErrorProbabilisticMethod';
    RESULTS{1,10}='ErrorClassBasedMethod';
    %%
    %pso solution obtention
 pso %obtention des coefficient w: BestSol
 save('psoBestSol100.mat','BestSol'); % load('psoBestSol100.mat');
    %%
    %Revise
    [line, column] = size(CaseCBRTraining);
    Training=CaseCBRTraining(1:line,1:n);
    Target= CaseCBRTraining(1:line,column);
    abcisse=grapheAbcisse(SolutionExpected,nbreTest); %1:1:nbreTest
    %Results3=ReviseFct3(Training,Target,CaseCBRTestPrime);
    for ik=1:nbreTest
    %for ik=1:30
        QueryCase=CaseCBRTest(ik,1:n);
        [SolutionReuse, SolutionMajorityRule, SolutionProbabilisticMethod, SolutionClassBasedMethod, MinimumSolSim, MoySolSim, StdSolSim]=ModelCBRdla(CaseCBRTraining, QueryCase, Casestab);
        %SolutionRevise=ReviseFct2(QueryCase);
        %SolutionRevise=Results3(ik);
        disp(['Results: case' num2str(ik)]);
        ExpectedSolution=CaseCBRTest(ik,n+1);
        %Pso solution
        PsoSolution=sum(QueryCase.*BestSol.Position);
        %Errors 
        ErrorPsoSolution=abs(ExpectedSolution-PsoSolution);
        ErrorMajorityRule=abs(ExpectedSolution-SolutionMajorityRule);
        ErrorProbabilisticMethod=abs(ExpectedSolution-SolutionProbabilisticMethod);
        ErrorClassBasedMethod=abs(ExpectedSolution-SolutionClassBasedMethod);
        %RESULTS
        RESULTS{ik+1,1}=['Cases' num2str(ik)];
        RESULTS{ik+1,2}=ExpectedSolution;
        RESULTS{ik+1,3}= PsoSolution;
        RESULTS{ik+1,4}=SolutionMajorityRule;
        RESULTS{ik+1,5}=SolutionProbabilisticMethod;
        RESULTS{ik+1,6}=SolutionClassBasedMethod;
        RESULTS{ik+1,7}=ErrorPsoSolution;
        RESULTS{ik+1,8}=ErrorMajorityRule;
        RESULTS{ik+1,9}=ErrorProbabilisticMethod;
        RESULTS{ik+1,10}=ErrorClassBasedMethod;       
    end
    save('RESULTATSdla.mat','RESULTS');

    