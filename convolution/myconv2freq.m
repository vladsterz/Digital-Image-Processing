function y=myconv2freq(h,x)
[Mh,Nh]=size(h);
[Mx,Nx]=size(x);

A=fft2(h,Mh+Mx-1,Nh+Nx-1);%fft2 with zeropadding
B=fft2(x,Mh+Mx-1,Nh+Nx-1);

y=ifft2(A.*B);%result
end