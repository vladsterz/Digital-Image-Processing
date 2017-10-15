function y = myInterp2(x)
xmin=ceil(min(x(:,1)));
xmax=floor(max(x(:,1)));

%ymin=floor(min(x(:,2)));
%ymax=floor(max(x(:,2)));

normX=sqrt(x(:,1).^2 + x(:,2).^2);
counter=1;
for xx=xmin:xmax
    i1=find(xx>x(:,1),1);
    i2=find(xx<x(:,1));
    i2=i2(end);
    
    ymin=ceil(x(i1,2));
    ymax=floor(x(i2,2));
    for yy=ymin:ymax
        n=norm([xx yy]);
        
        mins=find(abs(normX-n)>0,4);
        
        y(counter,1)=xx;
        y(counter,2)=yy;
        y(counter,3)=
        
        
        
        
        
        
        


end