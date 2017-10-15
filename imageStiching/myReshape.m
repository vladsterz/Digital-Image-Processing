function  Y=myReshape(X,st)

if st==0
    [M,N]=size(X);
    Y=zeros(M*N,3);
    for i=1:M
        for j=1:N
            k=M*(i-1) + j;
            Y(k,1)=i;
            Y(k,2)=j;
            Y(k,3)=X(i,j);
        end
    end
else
    M=max(X(:,1));
    N=max(X(:,2));
    Y=zeros(M,N);
    for i=1:M
        for j=1:N
            k=M*(i-1) + j;
            Y(i,j)=X(k,3);
        end
    end
end
    


end