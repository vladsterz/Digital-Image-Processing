 function demo2b
close all;


Im=load('images.mat');
h=estMask(Im.x1,Im.y1);
[Mh,Nh]=size(h);
[My2,Ny2]=size(Im.y2);
H=fft2(h,My2,Ny2);
c=1;
 
errors=zeros(numel(-10:0.5:10));
%efarmogh wiener filtroy se eikona xwris 8oruvo
for i=-10:0.5:10
   K=10^i;
   G=wienerfilter(H,K);%wiener filtro
   x2hat=invfilter(Im.y2,1./G,0);%anakataskeuh ths arxikhs
   x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));%ka8arismos epipleon pixels
   e=immse(Im.x2,x2hat);%error
   errors(c)=e;
   c=c+1;
end    
plot(-10:0.5:10,log(errors));
xlabel('log(K)');
ylabel('log(MSE(K))');
title('MSE for reconstructed image using Wiener filter');

%end Noiseless

% %3.1 Noissy

%eisagwgh thoryvoy sthn eikona y2
errors1=zeros(numel(-7:1),numel(-10:0.5:10));
for i=-7:1
    a=10^i;
    y2n=Im.y2+a*randn(size(Im.y2));%noise
    c=1;
    
    %loop gia ta K, omoia me parapanw
    %sto telos twn epanalhpsewn exoyme to sfalma anakataskeuhs
    %gia kathe K
    for j=-10:0.5:10
        K=10^j;
        G=wienerfilter(H,K);
        x2hat=invfilter(y2n,1./G,0);
        x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));
        e=immse(Im.x2,x2hat);
        errors1(i+8,c)=e;
        c=c+1;
    end 
    plot(-10:0.5:10,log(errors1(i+8,:)));
    hold on;
end
title('MSE with white noise a=10^i');
legend('i=-7','i=-6','i=-5','i=-4','i=-3','i=-2','i=-1','i=0','i=1','Location','northwest');
ylabel('log(MSE(K))');
xlabel('log(K)');
hold off;

% %end Noissy
% 
% %end 3.1
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %3.2


%eisagwgh thoryvo kai sthn y1
errors2=zeros(numel(-7:1),numel(-10:0.5:10));
errors3=zeros(numel(-7:1),numel(-10:0.5:10));
for i=-7:1
    c=1;
    a=10^i;
    y1n=Im.y1 + a*randn(size(Im.y1));%noise
    y2n=Im.y2 + a*randn(size(Im.y2));%noise
    
    hn=estMask(Im.x1,y1n);% ypologismos maskas paramorfowshs me thoryvo
    [Mh,Nh]=size(hn);
    Hn=fft2(hn,My2,Ny2);
    Hnx=fft2(hn,size(Im.y1,1),size(Im.y1,2));
    
    for j=-10:0.5:10
        K=10^j;
        G=wienerfilter(Hn,K);
        x2hat=invfilter(y2n,1./G,0);
        x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));
        
        G=wienerfilter(Hnx,K);
        x1hat=invfilter(y1n,1./G,0);
        x1hat=x1hat(1:(end-Mh+1),1:(end-Nh+1));
        
        e=immse(Im.x2,x2hat);
        errors2(i+8,c)=e;
        
        e=immse(Im.x1,x1hat);
        errors3(i+8,c)=e;
        
        c=c+1;
    end

    plot(-10:0.5:10,log(errors2(i+8,:)));
    hold on;
end
title('MSE with white noise a=10^i');
legend('i=-7','i=-6','i=-5','i=-4','i=-3','i=-2','i=-1','i=0','i=1','Location','northwest');
ylabel('log(MSE(K))');
xlabel('log(K)');
hold off;

figure();
for i=1:9
    plot(-10:0.5:10,log(errors3(i,:)));
    hold on;
end
xx=invfilter(Im.y1,fft2(h,size(Im.y1,1),size(Im.y1,2)),0);%arxikh xwris thoryvo
xx=xx(1:(end-Mh+1),1:(end-Nh+1));
e=immse(xx,Im.x1);
plot(-10:0.5:10,log(ones(numel(-10:0.5:10),1)*e));
hold off;
title('MSE with white noise a=10^i on x1');
legend('i=-7','i=-6','i=-5','i=-4','i=-3','i=-2','i=-1','i=0','i=1','Original','Location','northwest');
ylabel('log(MSE(K))');
xlabel('log(K)');

% 2

% 
% %proepeksergasia y1n
% 
%filtrarisma ths y1n wste na ka8arisoyme thn eikona apo ton thoryvo
errors3=zeros(numel(-7:1),numel(-10:0.5:10));
for i=-7:1
    c=1;
    a=10^i;
    y1n=Im.y1 + a*randn(size(Im.y1));
    y2n=Im.y2 + a*randn(size(Im.y2));
    
    hmed=ones(5)/25;
    
    y1n=filter2(hmed,y1n,'same');%FILTRARISMA
    hn=estMask(Im.x1,y1n);
    [Mh,Nh]=size(hn);
    Hn=fft2(hn,My2,Ny2);
    
    for j=-10:0.5:10
        K=10^j;
        G=wienerfilter(Hn,K);
        x2hat=invfilter(y2n,1./G,0);
        x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));
        e=immse(Im.x2,x2hat);
        errors3(i+8,c)=e;
        c=c+1;
    end
    %figure();
    plot(-10:0.5:10,log(errors3(i+8,:)));
    hold on;
end

title('MSE with white noise a=10^i on x1after filtering');
legend('i=-7','i=-6','i=-5','i=-4','i=-3','i=-2','i=-1','i=0','i=1','Location','northwest');
ylabel('log(MSE(K))');
xlabel('log(K)');
hold off;
end