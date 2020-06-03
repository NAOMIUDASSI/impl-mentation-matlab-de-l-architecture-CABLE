function wk=RandomInertiaW(w2,w1,kmax,n)
for k=1:n
    for j=1:kmax
        wk(k)=0.5+rand()/2;
    end
end