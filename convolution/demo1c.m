function z=demo1c

t=load('data.mat');
x=t.x;
y=t.y;

z=myconv2(x,y);
h=randi(255,16);

comp=zeros(1,9);%computatinal complexity of myconv2
theor=zeros(1,9);%theoretical complexity of myconv2
for k=2:10
    
    N=2^k;%our matrix will be N*N
    A=randi(255,N);%integers between 0 and 255
    theor(k-1)=N*N;%theoretical complexity
    tic;
    for rep=1:100
       myconv2(A,h);
    end
    comp(k-1)=toc;%computational complexity
end
temp=comp;
%normalization of complexities
comp=comp/max(comp);
theor=theor/max(theor);

delete c1.mat;
save c1.mat temp;

%ploting
i=2:10;

figure();
plot(i,comp,'r--o',i,theor,'b--o');
legend('Computational Complexity','Theoretical Complexity');
title('Complexity of convolution in the space domain');
xlabel('k,where N=2^k and N*N is the size of the matrix');
end