function [SolutionReuse, SolutionMajorityRule, SolutionProbabilisticMethod, SolutionClassBasedMethod, MinimumSolSim, MoySolSim, StdSolSim]=ModelCBRdla(CaseCBR, QueryCase, Casestab)
global w;
%%
%%Data loading
step=0.1;
alpha=0.4
%for alpha=0.1:step:0.9
    clear Similarities
    clear Similarities2
    clear CaseCBR2
    clear CaseSim
    clear mat
    %[CaseCBR, Casestxt, Casestab] = xlsread('Data2015to2017.xlsx');
    columnSize=length(CaseCBR(1,:));
    lineSize=length(CaseCBR(:,1));
    n=columnSize-1; %% number of attributes

    %New case entry
   % QueryCase=[1.4 1 3 3.2 3 2 4.1 5 1 7];

    %%
    %%Similarities computation:  cosine modified
    for i=1:lineSize
        %Similarities(i)=cosineM(QueryCase,CaseCBR(i,1:columnSize-1));
        Similarities(i,1)=i;
        Similarities(i,2)=cosineM(QueryCase,CaseCBR(i,1:columnSize-1)); % 1:columnSize-1 because the solution elements are not taken
    end
    Similarities;
    %Filtre suivant le seuil alpha
    k=1;
    found=0;
    for i=1:lineSize
        if( Similarities(i,2) >= alpha)
            Similarities2(k,:)=Similarities(i,:);
            k=k+1;
            found=1;
        end
    end
    %%
    %Parse Similarities2 to K-means
    %Creation du nouveau CaseCBR: CaseCBR2
    if(found==1)
        for i=1:length(Similarities2(:,1)) 
         ii=Similarities2(i,1);
         CaseCBR2(i,1:(n+1))=CaseCBR(ii,:);
         CaseCBR2(i,n+2)=ii;%les indices des cases
        end
        found=0;
    else
        CaseCBR2=CaseCBR;
        colonne=1:1:length(CaseCBR(:,1));
        CaseCBR2(:,n+2)=colonne';
    end

     X=CaseCBR2(:,1:n);
     kk=2;% to generate randomly
     opts = statset('Display','final');
    [idx,ctrs] = kmeans(X,kk,'Distance','cosine',...
                  'Replicates',5,'Options',opts);
    idx;
    ctrs;
    %%
    %knn
    % Group=[1 1 2 3 1 4 2 1];
    % Training=CaseCBR(:,1:n);
    % Class = knnclassify(QueryCase, Training, Group);

    Training=CaseCBR2(:,1:n);
    Group=idx;

    X = Training; % use all data for fitting
    Y = Group; % response data
    mdl = fitcknn(X,Y);
    alpha; 
    flwr = QueryCase; % the case to be predicted
    flwrClass = predict(mdl,flwr)
    
    %%
    %'Pour alpha=' num2str(alpha)  'les cas les plus similaires du QueryCase sont:'
    %Similar cases chosen
    v=1;
    %clear mat;
    for i=1:length(idx)
        if(idx(i)==flwrClass)
            %mat(i,:)=CaseCBR2(i,:);
            
            CaseSim(v,:)=CaseCBR2(i,1:n);
            SolCaseSim(v)=CaseCBR2(i,1+n);%%NEWWWWWWWWWW%%
            mat{1,v}=['Case' num2str(CaseCBR2(i,n+2)) ];
            v=v+1;
        end
    end
    disp(['Pour alpha=' num2str(alpha)  ' les cas les plus similaires du QueryCase sont:'])
    mat
       
    %%
    %Graphes
    clear Y
% % % %   % % % % figure
    Y(:,1)=QueryCase';
    legendInfo{1} = ['Query Case']%%
    for v=1:length(CaseSim(:,1))
        legendInfo{v+1} = [mat{1,v}]; %%
        Y(:,v+1)=CaseSim(v,:)';        
    end    
% % % %    % % % %plot(Y);
    legendInfo{1} = ['Query Case'];%%
    legend(legendInfo)
    title([' Similar cases to QueryCase for alpha=' num2str(alpha)])
    %legend('Query Case')
%end %END For Alpha

%%
%Reuse
%Majority Rule
SolutionMajorityRule=MajorityRule(QueryCase,CaseCBR2)

%ProbabilisticMethod
SolutionProbabilisticMethod=ProbabilisticMethod(QueryCase, CaseCBR2)

%ClassBasedMethod
SolutionClassBasedMethod=ClassBasedMethod(QueryCase, CaseCBR2)
wmax=0.9;
wmin=0.4;
kmax=15;
wk=Inertia(wmax,wmin,kmax,n)
SolInertia=sum(QueryCase.*wk)

wk=ChaoticInertiaW(wmax,wmin,kmax,n)
SolChaoticInertiaW=sum(QueryCase.*wk)

wk=ChaoticRandomInertiaW(wmax,wmin,kmax,n)
SolChaoticRandomInertiaW=sum(QueryCase.*wk)

wk=RandomInertiaW(wmax,wmin,kmax,n)
SolRandomInertiaW=sum(QueryCase.*wk)

SolutionReuse=SolutionClassBasedMethod

%Save Reuse solution
TotalCases=Casestab
nn=lineSize+1+1+1;
TotalCases{nn,1}='QueryCaseReuse';
reste=[QueryCase SolutionReuse];
for i=1:length(reste)
    TotalCases{lineSize+1+1+1,i+1}=reste(i);
end

%%
% % % %Revise
% % % Cmin=1;% minimal consumption
% % % SolutionRevise= ReviseFct(QueryCase,SolutionReuse,Cmin)
% % % 
% % % % TotalCases=Casestab
% % % % TotalCases{lineSize+1+1+1,1}='QueryCaseRevise';
% % % % reste=mat2cell([QueryCase SolutionRevise])
% % % % TotalCases{lineSize+1+1+1,2:n+2}=reste{1,1:11};
% % % %Save Revise solution
% % % TotalCases{nn+1,1}='QueryCaseRevise';
% % % reste=[QueryCase SolutionRevise];
% % % for i=1:length(reste)
% % %     TotalCases{nn+1,i+1}=reste(i);
% % % end
MoySolSim=mean(SolCaseSim); MinimumSolSim=min(SolCaseSim);
StdSolSim= std(SolCaseSim);
SolutionModel=SolutionReuse;