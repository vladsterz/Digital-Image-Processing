function demo

cd('./set_2');
I1=imread('segment_1.JPG');
I1=rgb2gray(I1);

I2=imread('segment_2.JPG');
I2=rgb2gray(I2);
cd('..');
tic

c1=myDetectHarrisFeatures(I1);
c2=myDetectHarrisFeatures(I2);

f1=extractSurfFeatures(I1,c1);
f2=extractSurfFeatures(I2,c2);



R=possiblePairs(f1,f2);


toc

figure(1);
imshow(I1);
hold on;
plot(c1(unique(R(:,1)),2),c1(unique(R(:,1)),1),'ro')
hold off;

figure(2);
imshow(I2);
hold on;
plot(c2(unique(R(:,2)),2),c2(unique(R(:,2)),1),'ro')
hold off;

end