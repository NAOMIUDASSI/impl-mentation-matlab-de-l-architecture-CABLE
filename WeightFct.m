 function w=WeightFct()   
[PairWiseComp, PairWiseCompMattxt, PairWiseCompMattab] = xlsread('Data2015to2017.xlsx',2);
n=length(PairWiseComp(:,1));
    %Construct normalized decision matrix
    a=PairWiseComp;
    for i=1:n
        for j=1:n
            c(i,j)=a(i,j)/sum(a(:,j));
        end
    end

    %Construct the weighted, normalized decision matrix
    for i=1:n
        w(i)=sum(c(i,:))/n;
    end