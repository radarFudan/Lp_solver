clc; % Clean the console, initialization
clear all;

profile on

tic;

%%%% input 

% If the data is stored in .m file
% testfile;

load('test_student.mat');

% 亲测我写的这个solver只能解不到一百个constraint的情况。🙈

% test data from http://www.netlib.org/lp/
% load('afiro.mat');%  succeeded.
% load('blend.mat');%  failed. 
% load('stocfor1.mat');%  failed.
% load('share2b.mat');%  failed. 
% load('sc50a.mat');%  failed. wrong answer
% load('sc50b.mat');%  succeeded. 
% failed are mainly due to the poor performance that the answer won't come out.

% load testfile.mat

% If the data is stored in .mat file
% Use load testfile.mat instead.



%%%% output

[mat, feasible, opt_x, opt_value, x_0,steps_1, steps_2] = simplex_lp(A, b, c)

toc;
t = toc;
profile viewer;
