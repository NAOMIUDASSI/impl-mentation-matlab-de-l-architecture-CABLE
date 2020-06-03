function result=cosineM(QueryCase,caseCBRi)
global w;
numerator=sum((w).*QueryCase.*caseCBRi);%Scalar product
denominator1=sqrt(sum(w.*(QueryCase.^2)));
denominator2=sqrt(sum(w.*(caseCBRi.^2)));
denominator=denominator1*denominator2;
result=numerator/denominator;

