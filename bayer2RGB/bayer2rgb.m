function [xc] = bayer2rgb(xb,M,N,type)
x=length(xb(:,1));
y=length(xb(1,:));
M=x;
N=y;
stepx=floor(x/M);
stepy=floor(y/N);
if (type==1)
    for j=2:2:N
        a=stepy*j;
        for i=2:2:M
            b=stepx*i;
            RGB=[xb(b,a-1) xb(b,a) xb(b-1,a)]';
            xc(i,j,:)=RGB;
            xc(i-1,j,:)=RGB;
            xc(i,j-1,:)=RGB;
            xc(i-1,j-1,:)=RGB;
        end
    end
else
    xb=padarray(xb,[1 1]);%zero pad
    for i=2:M+1
        q=(i-double(stepy>1))*stepy;%staring from the beggining
        a=mod(q,2);
        temp1=double(i==2||i==M+1);
        for j=2:N+1
            w=stepx*j;
            b=mod(w,2);
            temp2=double(j==2||j==N+1);
            horizontal=(xb(q,w-1)/2 + xb(q,w+1)/2)*(2^temp2);%to avoid computing errors
            vertical=(xb(q-1,w)/2 + xb(q+1,w)/2)*(2^temp1);
            if (a==0 && b==1)
                diagonal=(xb(q-1,w-1)/4 + xb(q-1,w+1)/4 + xb(q+1,w-1)/4 + xb(q+1,w+1)/4)*(2^(temp1+temp2));
                RGB=[diagonal horizontal/2+vertical/2 xb(q,w)]; %blue
            elseif (a==1 && b==0)
                diagonal=(xb(q-1,w-1)/4 + xb(q-1,w+1)/4 + xb(q+1,w-1)/4 + xb(q+1,w+1)/4)*(2^(temp1+temp2));
                RGB=[xb(q,w) horizontal/2+vertical/2 diagonal]; %red
            else %green
                if(a==1)
                    RGB=[horizontal xb(q,w) vertical];
                else
                    RGB=[vertical xb(q,w) horizontal];
                end
            end
            xc(i-1,j-1,:)=RGB;
        end
    end
end
end
                    
                    
                
                    
                    
                    
        
    

