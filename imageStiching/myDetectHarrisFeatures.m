%Harris Corner Detector
%corners = myDetectHarrisFeatures( I )
%I : MxN grayscale image,double values [0,1]
%corners : Kx2 , every row is the coordinates of a corner
%extracted using Harris Corner Detector
function corners = myDetectHarrisFeatures( I )

I=double(I)/256;%metatroph ths eikonas


[ M , N ]=size( I );

mask=fspecial('prewitt');
dx1=filter2(mask, I ,'same');%orizontia paragwgos
dx2=filter2(mask', I ,'same');%katheth
I11=dx1.*dx1;
I12=dx1.*dx2;
I22=dx2.*dx2;


%gaussian filter
s=1;
Nu=3;
w=fspecial('gaussian',Nu,s);%wighted matrix 
%%%%%%%%%%%%%%
k=.06;
%thr=0.00001;%%%%%set1
thr=0.01;%%%%set2 .01

%summations
A=conv2(I11,w,'same');
B=conv2(I12,w,'same');
C=conv2(I22,w,'same');

A=A(11:end-11,11:end-11);
B=B(11:end-11,11:end-11);
C=C(11:end-11,11:end-11);
% 
%cornersR=[];
% for i=15:M-15
%     for j=15:N-15
%         Mat=[A(i,j) B(i,j);B(i,j) C(i,j)];
%         R=det(Mat) - k*(trace(Mat))^2;
%         if R>thr
%            cornersR=[cornersR;[i j R]];
%         end
%     end
% end

T=A+C;
D=A.*C - B.*B;
R=D-k*T.*T;

[i,j]=find(R>thr);
cornersR=[i+11 j+11 R(find(R>thr))];%+11 logw twn akrianwn





corners=[];
%edw lunoume to provlhma thn emfaniseis pollwn suntetagmenwn
%poy praktika antistoixoun se 1 gwnia
%1)vriskoume oles tis poy einai konta se mia gwnia (au8ereto)
%se kapoia apostash
%2)vriskoume poio apo ayta exei ton megalutero suntelesth gwniothtas
%kai ton kratame
%3)diagrafoyme oles tis gwnies se ekeinh thn geitonia
%4)epanalambanoyme mexri na teleiwsoun oi gwnies

while ~isempty(cornersR)%%%
    %o pinakas cornersR periexei oles tis gwnies,akoma kai  aytes poy einai
    %konta
    
    %vriskoyme oles tis gwnies poy vriskontai konta se kapoia gwnia
    id=rangesearch(cornersR(:,1:2),cornersR(1,1:2),15,'Distance','euclidean');
    id=id{1};
    %anazhtoyme thn gwnia me to  megalutero metro gwniothtas kai thn
    %kratame
    i=find(cornersR(id,3)==max(cornersR(id,3)),1);
    corners=[corners ; cornersR(id(i),1:2)];
    %adeiazoyme ton pikana cornersR
    cornersR(id,:)=[];
end



if isempty(corners)
    return
end

%

% figure();
% title('Harris Corner Detector');
% imshow(I);
% hold on;
% plot(corners(:,2),corners(:,1),'ro');



    
end