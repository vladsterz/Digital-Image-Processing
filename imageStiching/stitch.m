function canvas = stitch( canvas , image , segment )
c1=myDetectHarrisFeatures(image);
c2=myDetectHarrisFeatures(segment);


f1=extractSurfFeatures(image,c1);
f2=extractSurfFeatures(segment,c2);



R=possiblePairs(f1,f2);


[A , B] = myransac(c1,c2,R);



c2t=myReshape(segment,0);%%allagh anaparastashs ths eikonas


c12=A\(c2t(:,1:2)' - repmat(B,1,size(c2t(:,1:2)',2)));

c12=[floor(c12') c2t(:,3)];



[Mim,Nim]=size(image);
[Mcan,Ncan]=size(canvas);
offset_i=Mcan/2 - Mim/2 +1;
offset_j=Ncan/2 - Nim/2 +1;

%offset_i=0;
%offset_j=0;
for i=1:size(c12(:,1),1)

    canvas(c12(i,1)+offset_i,c12(i,2)+offset_j)=double(c12(i,3))/256;

end


end