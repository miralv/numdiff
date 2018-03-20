%% solving the biharmonic eqution by solving the system of two poisson equations


%% Define function f and corresponding analytic solution

f =@(x,y) sin(2*pi*x).*sin(2*pi*y);
u_exact = @(x,y) sin(2*pi*x).*sin(2*pi*y)/(64*pi^4);

%% 

M = 30; %number of internal nodes in x-dir
N = 30; %number of internal nodes in y-dir
h = 1/(M+1);
k = 1/(M+1);
%construct the matrix fval with f(x,y) in all gridpoints
x = linspace(h,1-h,M);
y = linspace(k,1-k,N);
[X,Y] = meshgrid(x,y);
F = f(X,Y);
%reshape to vector-form, [f(row_1),f(row_2,...,f(row_M)]
fval = reshape(F,M*N,1);

%eq 1: solve grad^2 v = f
V =  fivepoint(fval,M,N);
%eq 2: solve grad^2 u = v
U = fivepoint(V,M,N);

%% Compute solution error in 2-norm, a.f.o. steplength %%
[errorx, errory] = error(f,u_exact);

errorx
errory
%% Plot & Business %%
figure(4)
loglog(errorx(1,:), errorx(2,:))
loglog(errory(1,:), errory(2,:))

grid on
xlabel('h/k')
ylabel('2-norm error x-direction')
title('loglog base 10 on x')

% 
% plt.loglog(errory[0], errory[1],basex=10)
% plt.grid(True)
% plt.xlabel('k')
% plt.ylabel('2-norm error y-direction')
% plt.title('loglog base 10 on x')
% 
% fig.savefig('solution.pdf')
% plt.savefig('convergence.pdf')


U_matrix = reshape(U,M,N)';
u_exact_matrix = u_exact(X,Y);
figure(1)
plot3(X,Y,U_matrix)
figure(2)
contour(X,Y,U_matrix)
figure(3)
plot3(X,Y,u_exact_matrix)

