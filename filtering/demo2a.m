%Inverse Filter
function demo2a
close all;

Im=load('images.mat');%image loading
h=estMask(Im.x1,Im.y1);%mask h
[Mh,Nh]=size(h);

x2hat=invfilter(Im.y2,h,1);%reconstructiong x2
x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));%void pixels

error=immse(Im.x2,x2hat);%mean squared error

%       PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();

subplot(1,2,1);
imshow(Im.x2);
title('Original Image');

subplot(1,2,2);
imshow(x2hat);
title(sprintf('Reconstructed with MSE=%e',error));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure();
for i=-7:1:-4
    a=10^i;
    y2n=Im.y2 + a*randn(size(Im.y2));%adding white noise
    
    x2hat=invfilter(y2n,h,1);%applying inverse filter to y2n
    x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));
    error=immse(x2hat,Im.x2);%MSE 

    subplot(2,2,i+8);
    imshow(x2hat);
    title(sprintf('a=%e  MSE=%e',a,error));
end




end
