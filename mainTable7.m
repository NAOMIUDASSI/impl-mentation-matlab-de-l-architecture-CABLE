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
    RESULTS{1,1}='k';
    RESULTS{1,2}='Index Of Case';
    %%
    [line, column] = size(CaseCBRTraining);
    Training=CaseCBRTraining(1:line,1:n);
    Target= CaseCBRTraining(1:line,column);
    abcisse=grapheAbcisse(SolutionExpected,nbreTest);
    i=2;% indice de la ligne d écriture dans RESULTS
    for ik=1:2:5 
    %for ik=1:30
        kNeighbors=ik; Case1=1;
        QueryCase=CaseCBRTest(Case1,1:n); % je ne prend qu'un seul case: le case 1 dans les Tests
        [kNeighborsIndex, IndexOfCases, SolutionReuse, SolutionMajorityRule, SolutionProbabilisticMethod, SolutionClassBasedMethod, MinimumSolSim, MoySolSim, StdSolSim]=ModelCBRdlaTable6(CaseCBR, QueryCase, Casestab, kNeighbors)
        disp(['Results: case' num2str(ik)]);
        ExpectedSolution=CaseCBRTest(ik,n+1);
        %RESULTS
        RESULTS{i,1}=kNeighbors;
        RESULTS{i,2}=IndexOfCases;  
        i=i+1;
    end
    
    %J'ajoute le cas où k=10
        kNeighbors=10;  Case1=1;
        QueryCase=CaseCBRTest(Case1,1:n); % je ne prend qu'un seul case: le case 1 dans les Tests
        [kNeighborsIndex, IndexOfCases, SolutionReuse, SolutionMajorityRule, SolutionProbabilisticMethod, SolutionClassBasedMethod, MinimumSolSim, MoySolSim, StdSolSim]=ModelCBRdlaTable6(CaseCBR, QueryCase, Casestab, kNeighbors)
        disp(['Results: case' num2str(ik)]);
        ExpectedSolution=CaseCBRTest(ik,n+1);
        %RESULTS
        RESULTS{i,1}=kNeighbors;
        RESULTS{i,2}=IndexOfCases;  
    save('RESULTATSdlaTable7.mat','RESULTS');

    