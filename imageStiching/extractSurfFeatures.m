%U-SURF descritor
function features = extractSurfFeatures(I,intPoints)
I=double(I)/256;%uni8 to double [0,1]
%I=padarray(I,[11 11]);

%intPoints=intPoints + 11*ones(size(intPoints));

features=zeros(length(intPoints),64);

haar=[-1 -1 ;1 1];

Gs=mat2cell(fspecial('gaussian',20,1),[5 5 5 5],[5 5 5 5]);

%ksekiname na ergazomaste gia kathe 
%shmeio endiaferontos

for i=1:length(intPoints)

    splitted=I(intPoints(i,1)-9:intPoints(i,1)+10,...
        intPoints(i,2)-9:intPoints(i,2)+10);%20x20 box gurw apo to int p
    subs=mat2cell(splitted,[5 5 5 5],[5 5 5 5]);%16 5z5 boxes
    
    for j=1:16%5x5
        temp=subs{j};
        tempindex=4*j-3;
        
        dx=conv2(temp,haar,'same');
        dy=conv2(temp,haar','same');
        
        %dx=dx.*Gs{j};
        %dy=dy.*Gs{j};
        
        
        a=sum(sum(dx));
        b=sum(sum(dy));
        c=sum(sum(abs(dx)));
        d=sum(sum(abs(dy)));
        
        features(i,tempindex:tempindex+3)=[a b c d];
    end
        
end



end