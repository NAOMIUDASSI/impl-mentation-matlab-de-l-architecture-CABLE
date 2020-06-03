function rSquare= RSquare(y,ycalc)
rSquare=1-sum((y-ycalc).^2)/sum((y-mean(y)).^2);