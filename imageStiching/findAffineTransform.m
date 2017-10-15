%p1 pinakas me suntetagmenes 3 shmeiwn
%p2 oi suntetagmenes meta apo affine transform sta p1
%ousiastika prepei na lusoyme 6 eksiswseis me 6 agnwstous
%fernoyme tis eksiswseis sthn morfh Ax=B opoy A,B gnwsta
%x dianusma agnwstwn 6x1
function [ A , B ] = findAffineTransform( p1 , p2 )
AA=[p1(1,1) p1(1,2) 0 0 1 0; ...
    0 0 p1(1,1) p1(1,2) 0 1; ...
    p1(2,1) p1(2,2) 0 0 1 0; ...
    0 0 p1(2,1) p1(2,2) 0 1; ...
    p1(3,1) p1(3,2) 0 0 1 0; ...
    0 0 p1(3,1) p1(3,2) 0 1];
p2=p2';
BB=p2(:);

temp=AA\BB;

A=[temp(1) temp(2);temp(3) temp(4)];
B=[temp(5);temp(6)];

end