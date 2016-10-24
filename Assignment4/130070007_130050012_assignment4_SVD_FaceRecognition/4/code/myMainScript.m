%% MyMainScript

tic;
%% Your code here
A=dlmread('./matA.txt');
[U, S, V] = mySVD(A);   
toc;
