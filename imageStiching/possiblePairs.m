%
function R = possiblePairs( features1 , features2 )
%thr=.1;%%set1
%thr=1;%%set2


R=[];

for i=1:size(features1,1)
    thr=immse(features1(i,:),features2(1,:));
    min=[];
    for j=1:size(features2,1)
        if immse(features1(i,:),features2(j,:))<thr
            min=[i j];
            thr=immse(features1(i,:),features2(j,:));
        end
    end
    R=[R;min];
end
        

end