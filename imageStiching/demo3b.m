function demo3b
cd('./set_2');
seg1=rgb2gray(imread('segment_1.JPG'));%estw oti xtizoume gyrw apo aythn
seg2=rgb2gray(imread('segment_2.JPG'));
seg3=rgb2gray(imread('segment_3.JPG'));
seg4=rgb2gray(imread('segment_4.JPG'));
cd('..');


[M,N]=size(seg1);

camvas=double(ones(5000,5000));
[Mcan,Ncan]=size(camvas);

%vazoume to segment 1 sto kentro toy camva kai 
%xtizoyme gyrw toy



camvas((Mcan/2 - M/2 + 1):(Mcan/2 + M/2),...
    (Ncan/2 - N/2 +1 ):(Ncan/2 + N/2))=double(seg1)/256;


tic
camvas=stitch(camvas,seg1,seg2);

camvas=stitch(camvas,seg1,seg3);

camvas=stitch(camvas,seg1,seg4);

figure();
%camvas=gray2rgb(camvas);

[i,j]=find(camvas~=1);
imin=min(i);
imax=max(i);
jmin=min(j);
jmax=max(j);
camvas=camvas(imin:imax,jmin:jmax);
imshow(camvas)
toc


end