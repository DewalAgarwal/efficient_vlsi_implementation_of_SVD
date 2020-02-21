
store=[1,15]; 

for k = 1:15
% NXN Matrix whose SVD has to be calculated
%M = [1 2 3 4;5 6 7 8;9 10 11 12; 13 14 15 16];
M = round(1000*rand(4));

% Initialization of the four units with the values from the Matrix
P11 = [M(1,1) M(1,2);M(2,1) M(2,2)];           %UNIT 1
P12 = [M(1,3) M(1,4);M(2,3) M(2,4)];           %UNIT 2
P21 = [M(3,1) M(3,2);M(4,1) M(4,2)];           %UNIT 3
P22 = [M(3,3) M(3,4);M(4,3) M(4,4)];           %UNIT 4

% Number of iterations required for precise value of the eigenvalues
n = 1000;

for i=1:n
    
% Calculation of the angle for the rotation of the off diagnol elements
    theta1 = thetal(P11(1,1),P11(1,2),P11(2,1),P11(2,2));
    theta2 = thetal(P22(1,1),P22(1,2),P22(2,1),P22(2,2));
    theta3 = thetar(P11(1,1),P11(1,2),P11(2,1),P11(2,2));
    theta4 = thetar(P22(1,1),P22(1,2),P22(2,1),P22(2,2));


% Diagnol units of the processor for anhilation of off diagnol elements
%within the unit
    P11=[cos(theta1) -sin(theta1);sin(theta1) cos(theta1)]*(P11*[cos(theta3) sin(theta3);-sin(theta3) cos(theta3)]);
    P22=[cos(theta2) -sin(theta2);sin(theta2) cos(theta2)]*(P22*[cos(theta4) sin(theta4);-sin(theta4) cos(theta4)]);

% Off-Diagnol units of the processor
    P12=([cos(theta1) -sin(theta1);sin(theta1) cos(theta1)]*P12)*[cos(theta4) sin(theta4);-sin(theta4) cos(theta4)];
    P21=[cos(theta2) -sin(theta2);sin(theta2) cos(theta2)]*(P21*[cos(theta3) sin(theta3);-sin(theta3) cos(theta3)]);

% Interchanging the elements between the Diagnol and Off-Diagnol units.
    [P11(1,2), P12(1,1)] = swap(P11(1,2), P12(1,1));
    [P11(2,2), P22(1,1)] = swap(P11(2,2), P22(1,1));
    [P11(2,1), P21(1,1)] = swap(P11(2,1), P21(1,1));
    [P21(2,2), P22(2,1)] = swap(P21(2,2), P22(2,1));
    [P12(2,2), P22(1,2)] = swap(P12(2,2), P22(1,2));
    [P12(2,1), P21(1,2)] = swap(P12(2,1), P21(1,2));
end


% Forming the SVD matrix using values from all the units after all
% iterations
A = [P11 P12;P21 P22];

% Eigenvalue Normalization sorting in decending order.
Dg = diag(sort(abs(diag(A)),'descend'));
I = eye(size(A));
A = Dg - (A.*~eye(size(A)));

% Inbuilt MATLAB function for calculation of SVD. 
[U1, V1] = svd(M);

% Error vector function
Error = diag(abs(V1 - Dg));

Ev = diag(V1);
TotalError = sum(Error);
TotalEv = sum(Ev);

point = TotalError/TotalEv;
store(1,k) = point;

Diff = (Error./diag(V1));
end

