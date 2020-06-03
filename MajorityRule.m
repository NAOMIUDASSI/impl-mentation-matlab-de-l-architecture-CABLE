function Solution=MajorityRule(QueryCase,CaseCBR2)
n=length(QueryCase);
X = CaseCBR2(:,n+1); % Solution column
uniqueX = unique(X);
countOfX = hist(X,uniqueX);%Calule du nombre d occurence par solution
[maxi, indexMaxi]=max(countOfX);

I=find(countOfX(:)==maxi);
if(length(I)==1)
    Solution=uniqueX(indexMaxi);
else if (length(I)>1)
        Solution=uniqueX(indexMaxi);
%         for v=1:length(I)
%             CasesClassInd{}
%         
    end
end
