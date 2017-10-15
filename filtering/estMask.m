%h=estMast(x,y) prospa8ei na ypologisei to veltisto filtro
%poy exei epivlh8ei stin eikona x typoy 'motion'.
function h = estMask(x,y)
[Mx,Nx]=size(x);
[My,Ny]=size(y);
Mxy=My-Mx;
Nxy=Ny-Nx;
y=y((Mxy/2 +1):(Mx+Mxy/2),(Nxy/2 +1):(Nx + Nxy/2));%eu8ugrammish twn eikonwn

error=Inf;

for len=1:100
    for ang=0:360
       hh=fspecial('motion',len,ang);
       [Mh,Nh]=size(hh);
       if ~isequal([Mh Nh]+[Mx Nx] - [1 1],[My Ny])%elegxoyme filtra poy exoyn epi8umhtes diastaseis

           continue;
           
       end
       
       yhat=filter2(hh,x,'same');
       
       
       
       e=immse(y,yhat);%sfalma anakataskeuhs
       if(e<error)
         h=hh;
         error=e;
         %[ang e]
       end
       
   end
    
end


end