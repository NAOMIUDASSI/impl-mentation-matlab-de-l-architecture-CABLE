function Solution=ClassBasedMethod(QueryCase, CaseCBR2)
n=length(QueryCase);
X = CaseCBR2(:,n+1); % Solution column similar Case
Ci = unique(X);% Les différentes solutions repertoriées dans les similar Case

for k=1:length(CaseCBR2(:,1))
    TabSim(k)=cosineM(QueryCase,CaseCBR2(k,1:n));
end

for i=1:length(Ci)
    Sol=Ci(i);
    FindLineSol=ismember(CaseCBR2(:,n+1),Sol)';
    Moyennes(i)=mean(TabSim.*FindLineSol);
end

[mini, indexMin]=min(Moyennes);
Solution=Ci(indexMin);
