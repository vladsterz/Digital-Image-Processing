function errory = wienerExp(er)
if er==1
    last=-7;
else
    last=1;
end

errory=zeros(numel(-7:last),numel(-10:0.5:10));
Im=load('images.mat');
y2=Im.y2;
[My2,Ny2]=size(y2);

h=estMask(Im.x1,Im.y1);
[Mh,Nh]=size(h);
H=fft2(h,My2,Ny2);


for i=-7:last
    a=10^i;
    
    if er==2
        y2=Im.y2+a*randn(size(Im.y2));
    elseif er==3
        y1=Im.y1+a*randn(size(Im.y1));
        y2=Im.y2+a*randn(size(Im.y2));
        h=estMask(Im.x1,y1);
        [Mh,Nh]=size(h);
        H=fft2(h,My2,Ny2);
    elseif err==4
        medfil=ones(5)./25;
        y1=Im.y1+a*randn(size(Im.y1));
        y1=filter(medfil,y1);
        
        y2=Im.y2+a*randn(size(Im.y2));
        h=estMask(Im.x1,y1);
        [Mh,Nh]=size(h);
        H=fft2(h,My2,Ny2);
    end
        
    c=1;
    
    for j=-10:0.5:10
        K=10^j;
        G=wienerfilter(H,K);
        x2hat=invfilter(y2,1./G,0);
        x2hat=x2hat(1:(end-Mh+1),1:(end-Nh+1));
        e=immse(Im.x2,x2hat);
        errory(i+8,c)=e;
        c=c+1;
    end
end





end