function wk=ChaoticInertiaW(w2,w1,kmax,n)

for k=1:n
    z=rand();
    for j=1:kmax
        wk(k)=w2*z+(w1-w2)*(kmax-k)/kmax;
        z=4*z*(1-z);
    end
end