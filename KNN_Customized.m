function [predicted_label, kNeighborsIndex, kNeighborsSol, MinimumSolSim, MoySolSim, StdSolSim]=KNN_Customized(kNeighbors,training,training_labels,QueryCase)
k=kNeighbors;
[LineNumber, ColumnNumber]=size(training);
%Extend Training by adding a column for cases index
%%
  %%Similarities computation:  cosine modified
    for i=1:LineNumber
        Similarities(i,1)=i;
        %Similarities(i,2)=cosine(QueryCase,training(i,1:ColumnNumber-1)); 
        Similarities(i,2)=distEuclidienne(QueryCase,training(i,1:ColumnNumber-1)); 
        %Similarities(i,2)=cosineM(QueryCase,training(i,1:ColumnNumber-1));  % 1:columnSize-1 because the solution elements are not taken
    end
%%
%Trier les Similarities par ordre décroissant:
[SimilaritiesSorted, indexSorted] = sortrows(Similarities,2,'descend');%on pouvais utiliser 'ascend' pour le trie croissant
%%
%Selection des votants
LesVotants=SimilaritiesSorted(1:k,:);
IndexDesvotants=LesVotants(:,1);
SimilariteDesvotants=LesVotants(:,2);
trainingCasesDesVotants=training(IndexDesvotants,:);
SolDesvotants=trainingCasesDesVotants(:,ColumnNumber);%LesVotants(:,1);

%% 
%Trouver le label majoritaire parmi les votants
LabelsDesVotants=training_labels(IndexDesvotants);% le tableau "LabelsDesVotants" peut contenir plusieurs fois le meme label à des position différentes
%Label le plus voté lors du scrutin
% X=LabelsDesVotants
% uniqueX = unique(X)
% countOfX = hist(X,uniqueX);%Calule du nombre d occurence par solution
% [BestScore, indexBestScore]=max(countOfX);
% LabelMajoritaireChezLesVotants=uniqueX(indexBestScore);
[LabelMajoritaireChezLesVotants, BestScore] = mode(LabelsDesVotants);
%%
%LES SORTIES:
predicted_label=LabelMajoritaireChezLesVotants;
kNeighborsIndex=IndexDesvotants
kNeighborsSol=SolDesvotants;
MinimumSolSim=min(SolDesvotants);
MoySolSim=mean(SolDesvotants);
StdSolSim=std(SolDesvotants);
%%
