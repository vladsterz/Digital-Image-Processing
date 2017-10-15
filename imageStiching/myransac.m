function [ A , B ] = myransac( intPoints1, intPoints2, R)

repNumb=1000;
%thr=.001;%set1
thr=2;%set2
maxK=-1;%%maximum gia ta shmeia endiaferontos

uni=unique(R(:,1),'stable');

for i=1:repNumb
    %%%3random points
    rng('shuffle');
    %a=randi(length(R),1000,1);%%tyxaia shmeia apo ton pinaka R
    %a=unique(a,'stable');%%diaforetika shmeia.
    %an epilegei to idio shmeio, den yparxei lush gia thn find Affine
    %a=a(1:3);%3 random shmeia
    %%%end
    
    
    a=randi(length(uni),3,1);
    while length(unique(R(a,2)))~=3 || length(unique(R(a,1)))~=3
        a=randi(length(uni),3,1);
    end
    %if length(unique(R(a,2))) ~= 3
    %    continue;
    %end
    x1=R(a,1);
    x2=R(a,2);
    
    
    [ Ai , Bi ]=findAffineTransform( intPoints1(x1,:) , intPoints2(x2,:));

    bb=repmat(Bi,1,size(intPoints1',2));
    
    
    transf_points=Ai*intPoints1' + bb;%%metasxhmatismena ola ta shmeia
    % gia logous aplothtas tha sugkrinoyme ta metasxhmatismena shmeia
    %me ta antistoixa apo ton pinaka R
    
    transf_points=transf_points';
    
    differences=transf_points(R(:,1),:) - intPoints2(R(:,2),:); %Nx2
    
    %eukleidia apostash shmeiwn
    xx=differences(:,1).^2;
    yy=differences(:,2).^2;
    difs=sqrt(xx+yy);
    
    k=sum(difs<thr);%
    %maximum ari8mos shmeiwn poy tairiazoyn
    if k>maxK
        maxK=k;
        A=Ai;
        B=Bi;
    end
    
end




end

