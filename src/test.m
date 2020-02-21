% testvar = [1,10];
% 
% for j = 1:10
%     p = 2*1;
%     testvar(1,j) = p;
% end

%COL = [1;2;3;4];
%testvar = sum(COL);

A= [1 2 3 0; 4 5 6 0; 7 8 9 0; 0 0 0 0];
[U, V] = svd(A);
B = [1 2 3; 4 5 6; 7 8 9];
[U1, V1] = svd(B);
