function ee = minimizeError(x)
global  CaseCBRTraining
m=length(CaseCBRTraining(:,1)); 
n=length(CaseCBRTraining(1,:))-1; %nbre d'attributs
R=CaseCBRTraining(:,n+1);%colonne des solutions
e=zeros(m,1);
e=e-R;%j initialise les ei à -Ri
for i=1:m
 for j=1:n
     e(i)=e(i)+CaseCBRTraining(i,j)*x(j);
 end
end

ee=sqrt(sum(e.*e));
