function demo3b
close all;

a=load('images.mat');

error=Inf;

for i=-10:0.5:10
    K=10^i;
    G=wienerfilter(H,K);

end