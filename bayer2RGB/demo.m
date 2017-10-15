function demo
clear all;
a=imread('images.jpg');
x1=bayer2rgb(a,960,1280,1);
figure();
image(x1);
title('Nearest neighboor 960x1280');
x2=bayer2rgb(a,320,420,1);
figure();
image(x2);
title('Nearest neighboor 320x420');
x3=bayer2rgb(a,960,1280,2);
figure();
image(x3);
title('Billinear interpolation 960x1280');
x4=bayer2rgb(a,320,420,2);
figure();
image(x4);
title('Billinear interpolation 320x420');
end
