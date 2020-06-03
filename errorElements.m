function [errorL]=errorElements(V,W,n)
for k=1:n
        errorL(k)=abs(V(k)-W(k));
end
