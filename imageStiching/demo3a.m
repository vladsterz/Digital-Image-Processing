function demo3a

tic


my_Image=imread('originalImage.jpg');
seg1=imread('segment_1.jpg');
seg2=imread('segment_2.jpg');
seg3=imread('segment_3.jpg');

canvas=ones(size(my_Image));

%canvas=stitch(canvas,my_Image,seg1);
canvas=stitch(canvas,my_Image,seg2);
1
%canvas=stitch(canvas,my_Image,seg3);

figure();
imshow(canvas);


toc

end