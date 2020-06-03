function r=rmse(data,estimate,n)
    %r= sqrt(sum((data(:)==estimate (:)).^2 / numel(data)))
     %r= sqrt(sum((data - estimate).^2)/n);
     r = sqrt( sum( (data(:)-estimate(:)).^2) / numel(data) ); 