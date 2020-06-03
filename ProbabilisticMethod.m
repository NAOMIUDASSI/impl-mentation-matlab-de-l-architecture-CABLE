function Solution=ProbabilisticMethod(QueryCase, CaseCBR2)
n=length(QueryCase);
X = CaseCBR2(:,n+1); % Solution column similar Case
Ci = unique(X);% Les différentes solutions repertoriées dans les similar Case
for k=1:length(CaseCBR2(:,1))
    TabSim(k)=cosineM(QueryCase,CaseCBR2(k,1:n));
end
denominator=sum(TabSim);
for i=1:length(Ci)
    Sol=Ci(i);
    delta=ismember(X,Sol)';
    numerator=sum(TabSim.*delta);
    Proba(i)= numerator./denominator;
end
[maxi, indexMaxi]=max(Proba);
Solution=Ci(indexMaxi);


% somme=0;
% for k=1:length(CaseCBR2(:,1))
%     somme=somme+cosineM(QueryCase,CaseCBR2(k,1:n));
% end