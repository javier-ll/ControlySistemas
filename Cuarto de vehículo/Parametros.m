%% Modelo de un cuarto de vehículo
Mc=250;
Mr=45;
Kc=16000;
Kr=160000;
Cc=1000;
A=[0, 0, 1, -1;
    0, 0, 0, 1;
    -Kc/Mc, 0, -Cc/Mc, Cc/Mc;
    Kc/Mr, -Kr/Mr, Cc/Mr, -Cc/Mr];
Bu=[0; 0; -1/Mc; 1/Mr];
Bp=[0; -1; 0; 0];
C=eye(4);
C1=[1, 0, 0, 0; % Nueva matriz donde la salida son las variables de estado que efectivamente pueden medirse
    -Kc/Mc, 0, -Cc/Mc, Cc/Mc];
D=[0; -1/Mc];

%% Observabilidad
O=[C;
    C*A;
    C*A^2;
    C*A^3];
O1=[C1;
    C1*A;
    C1*A^2;
    C1*A^3];
%Muestro matriz de observabilidad
%syms kc kr mc cc mr,
%A2=[0, 0, 1, -1;
%    0, 0, 0, 1;
%    -kc/mc, 0, -cc/mc, cc/mc;
%    kc/mr, -kr/mr, cc/mr, -cc/mr];
%O2=[C;
%    C*A2;
%    C*A2^2;
%    C*A2^3];
%Analizo observabilidad y controlabilidad
O1=rank(O1);
Control=[Bu, A*Bu, A^2*Bu, A^3*Bu];
Control=rank(Control);
fprintf('El sistema es observable y de rango: %d\n',O1);
fprintf('El sistema es controlable y de rango: %d\n',Control);
%% Control skyhook y groundhook
Cmax=900;
Cmin=100;
%% Control híbrido
alpha=0.5;
%% Parámetros LQE
Q_lqe = diag([0;0;0.0001;1.1]);  %[0;0;0.01;0.8] [0;0;0.0001;1.1]
R_lqe = diag([1.94e-11;6.88e-5]);   %[1.94e-11;6.88e-5]
[K, S, e] = lqr(A', C1', Q_lqe, R_lqe);  % Computa la ganancia del observador
L=K';
A_obs = A - L * C1;
%P=diag([100;10;100;100]);
%% Parámetros filtro de Kalman
B=[Bu Bp];
D1=[0, 0; -1/Mc, 0];
sys_c = ss(A, B, C1, D1);  % Modelo continuo
T_s = 0.0001;  % Periodo de muestreo
Q = diag([0;0;0.001;2.6]);  %[0;0;0.001;2.6]
R = diag([1.94e-6;6.88e-5]);   %[1.94e-11;6.88e-5]
sys_d = c2d(sys_c, T_s, 'zoh');  % Discretización con retención de orden cero (ZOH)

% Extraer las matrices discretizadas
A_d = sys_d.A;
B_d = sys_d.B;
C_d = sys_d.C;
D_d = sys_d.D;
Bu_d = B_d(:,1);
Du_d = D_d(:,1);
%A_d1=eye(4)+A*T_s;     % Euler hacia adelante
A_d1 = (eye(4)+0.5*A*T_s)*(eye(4)-0.5*A*T_s)^(-1);      % Transformada bilineal
B_d1 = A^(-1)*(A_d1-(eye(4)))*B;
%B_d2 = (eye(4)-T_s/2*A)*B;
C_d1 = C1;
D_d1 = D1;
Bu_d1 = B_d1(:,1);
Du_d1 = D_d1(:,1);
R_d1=R/T_s;
R_d=R;
F=[-A, Q;
    zeros(4,4), A']*T_s;
G=exp(F);
Q_d2=G(5:8,5:8)'*G(1:4,5:8);
Q_d=diag(Q_d2);
Q_d=diag(Q_d);  %diag([4,4,3.94,3.458]);
Q_d1=diag([4,4,0.94,0.458]);   %[1,1.001,0.000004,0.0008]
mex cuantizador_acelerometro.c;
mex cuantizador_desplazamiento.c;