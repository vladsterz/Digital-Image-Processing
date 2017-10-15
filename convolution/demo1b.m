function demo1b
close all;
%demo1c;
%demo1d;


c1=load('c1.mat');%space domain convolution
c2=load('c2.mat');%frequency domain convolution

c3=zeros(1,9);
h=randi(255,16);
for k=2:10
    N=2^k;
    A=randi(255,N);
    tic;
    for rep=1:100
        conv2(A,h);
    end
    c3(k-1)=toc;
end

c1=c1.temp/max(c1.temp);
c2=c2.temp/max(c2.temp);
c3=c3/max(c3);

%plot
figure();
i=2:10;
plot(i,c1,'r--o',i,c2,'b--o',i,c3,'g--o');
title('Computational Complexity of Algorithms');
legend('myconv2','myconv2freq','conv2');
xlabel('k,where N=2^k and N*N is the size of the matrix');





end