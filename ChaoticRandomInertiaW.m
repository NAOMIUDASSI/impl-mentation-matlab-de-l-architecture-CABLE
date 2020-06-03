function wk=ChaoticRandomInertiaW(w2,w1,kmax,n)
for k=1:n
    z=rand();
    for j=1:kmax
        wk(k)=0.5*rand()+0.5*z;
        z=4*z*(1-z);
    end
end