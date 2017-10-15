%efarmogh antistrofou filtroy
function x2hat = invfilter(y2,h,isMask)
[M,N]=size(y2);
if isMask
   H=fft2(h,M,N);
   x2=fft2(y2)./H;
  
else
   x2=fft2(y2)./h;
end
x2hat=ifft2(x2);


end