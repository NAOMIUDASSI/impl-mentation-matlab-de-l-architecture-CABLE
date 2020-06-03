function result=cosine(QueryCase,caseCBRi)
global w;
numerator=sum(QueryCase.*caseCBRi);%Scalar product
denominator1=sqrt(sum((QueryCase.^2)));
denominator2=sqrt(sum((caseCBRi.^2)));
denominator=denominator1*denominator2;
result=numerator/denominator;