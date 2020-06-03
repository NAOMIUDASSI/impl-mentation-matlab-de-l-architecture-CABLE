clear;clc
X=2
uniqueX = unique(X)
countOfX = hist(X,uniqueX)%Calule du nombre d occurence par solution
[BestScore, indexBestScore]=max(countOfX)
LabelMajoritaireChezLesVotants=uniqueX(indexBestScore)
