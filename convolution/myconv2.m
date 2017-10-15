function y=myconv2(h,x)

%To avoid negative indexes in matrices,we need a to be the bigger matrix
%The output remains the same since conv(a,b)=conv(b,a)
if(length(x(:,1))>length(h(:,1)))
    temp=h;
    h=x;
    x=temp;
end
[Ma,Na]=size(h);
[Mb,Nb]=size(x);
y=zeros(Ma + Mb -1,Na + Nb -1);%preallocating space for output
x=rot90(x,2);%rotating b twice to get b(-k,-m)
for k=1:Ma + Mb -1
    %Variables that show in which part of the convolution we are at
    t1=double(k<Mb);
    t2=double((k>=Mb)&(k<=Ma));
    t3=double(k>Ma);
    %Local matrices with dynamic size that index a and b matrices to the
    %values that will be needed
    ak=(t1 + (t2+t3)*(k-Mb+1)):((t1+t2)*k +t3*Ma);
    bk=((t1*(Mb-k+1)) + t2 + t3:((t1+t2)*Mb + t3*(Mb-(k-Ma))));
    for m=1:Na + Nb -1
        %Variables that show in which part of the convolution we are at
        r1=double(m<Nb);
        r2=double((m>=Nb)&(m<=Na));
        r3=double(m>Na);
        %Local matrices with dynamic size that index a and b matrices to the
        %values that will be needed
        am=(r1 + (r2+r3)*(m-Nb+1)):((r1+r2)*m + r3*Na);
        bm=((r1*(Nb-m+1)) + r2 + r3):((r3*(Nb-(m-Na))+(r2+r1)*Nb));
        %Since we got the needed parts of a and b we multiply elementwise
        %the matrices and get the sumation of this product to get the
        %convolution for each index
        y(k,m)=sum(sum(h(ak,am).*x(bk,bm)));
    end
end
end
