function demo1a
close all;


comp=zeros(1,9);%computatinal complexity of fft2
theor=zeros(1,9);%theoretical complexity of fft2 (known as N*N*log(N))
for k=2:10
    
    N=2^k;%our matrix will be N*N
    A=randi(255,N);%integers between 0 and 255
    theor(k-1)=N*N*log(N);%theoretical complexity
    tic;
    for rep=1:100
       fft2(A); 
    end
    comp(k-1)=toc;%computational complexity
end

%normalization of complexities
comp=comp/max(comp);
theor=theor/max(theor);

%ploting
i=2:10;

figure();
plot(i,comp,'r--o',i,theor,'b--o');
legend('Computational Complexity','Theoretical Complexity');
title('Complexity of fft2');
xlabel('k,where N=2^k and N*N is the size of the matrix');
end