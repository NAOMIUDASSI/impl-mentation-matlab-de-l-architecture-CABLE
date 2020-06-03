function wk=Inertia(wmax,wmin,kmax,n)
for k=1:n
    for j=1:kmax
        wk(k)=wmax-(wmax-wmin)*k/kmax;
    end
end