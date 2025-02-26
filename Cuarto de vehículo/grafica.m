% Limpieza inicial
clear
close all
clc
matlabrc

% Configuración inicial
font_label = 25;
font_tick = 20;
line_wd = 1.5; % Grosor reducido de las líneas

%%Terreno
load('terreno.mat')
% Acceder al timeseries dentro de Group_1
terreno_timeseries = Group_1{1};
% Extraer los datos del timeseries
time_terreno = terreno_timeseries.Time;  % Tiempo de la señal
data_terreno = terreno_timeseries.Data;  % Valores de la señal
% Crear una figura
figure;
plot(time_terreno, data_terreno, 'r-', 'LineWidth', 2, 'DisplayName', 'Velocidad vertical del terreno');  % Señal continua

% Configuración de los gráficos
xlabel('Tiempo [s]', 'FontSize', 20);
ylabel('Amplitud [m/s]', 'FontSize', 20);
title('Variación de la velocidad vertical del terreno respecto al tiempo', 'FontSize', 25);
set(gca, 'FontSize', font_tick);
legend('show');
grid on;
%saveas(gcf, 'Terreno.png');

%% Modelo ideal
load('resultados_ideales_pasivos.mat')
t_pasivo=out.scope_ideal.time;
x1_pasivo=out.scope_ideal.signals(2).values;
x2_pasivo=out.scope_ideal.signals(3).values;
x3_pasivo=out.scope_ideal.signals(4).values;
x4_pasivo=out.scope_ideal.signals(5).values;
dx3_pasivo=out.scope_ideal.signals(7).values;
load('resultados_ideales_skyhook.mat')
t1 = out.scope_ideal.time;              % Tiempo
x1_ideal_skyhook=out.scope_ideal.signals(2).values;
x2_ideal_skyhook=out.scope_ideal.signals(3).values;
z_c_ideal_skyhook=x1_ideal_skyhook+x2_ideal_skyhook;
x3_ideal_skyhook=out.scope_ideal.signals(4).values;
x4_ideal_skyhook=out.scope_ideal.signals(5).values;
U_ideal_skyhook=out.scope_ideal.signals(6).values;
dx3_ideal_skyhook=out.scope_ideal.signals(7).values;
load('resultados_ideales_groundhook.mat')
t2 = out.scope_ideal.time;
x1_ideal_groundhook=out.scope_ideal.signals(2).values;
x2_ideal_groundhook=out.scope_ideal.signals(3).values;
z_c_ideal_groundhook=x1_ideal_groundhook+x2_ideal_groundhook;
x3_ideal_groundhook=out.scope_ideal.signals(4).values;
x4_ideal_groundhook=out.scope_ideal.signals(5).values;
U_ideal_groundhook=out.scope_ideal.signals(6).values;
dx3_ideal_groundhook=out.scope_ideal.signals(7).values;
load('resultados_ideales_hibrido.mat')
t3 = out.scope_ideal.time;
x1_ideal_hibrido=out.scope_ideal.signals(2).values;
x2_ideal_hibrido=out.scope_ideal.signals(3).values;
z_c_ideal_hibrido=x1_ideal_hibrido+x2_ideal_hibrido;
x3_ideal_hibrido=out.scope_ideal.signals(4).values;
x4_ideal_hibrido=out.scope_ideal.signals(5).values;
U_ideal_hibrido=out.scope_ideal.signals(6).values;
dx3_ideal_hibrido=out.scope_ideal.signals(7).values;
% Gráfico z_c ideal
figure;
plot(t_pasivo, x1_pasivo+x2_pasivo, '-', 'LineWidth', line_wd, 'DisplayName', 'z_{c}pasivo(t)');
hold on;
plot(t1, z_c_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'z_{c}skyhook(t)');
hold on;
plot(t2, z_c_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'z_{c}groundhook(t)');
hold on;
plot(t3, z_c_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'z_{c}híbrido(t)');
hold off;

% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m]', 'FontSize', font_label);
title('Desplazamiento absoluto del chasis según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion zc ideal.png'); % Guarda cada gráfico
% Gráfico x2 ideal
figure;
plot(t_pasivo, x2_pasivo, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{2}pasivo(t)');
hold on;
plot(t1, x2_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{2}skyhook(t)');
hold on;
plot(t2, x2_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{2}groundhook(t)');
hold on;
plot(t3, x2_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{2}híbrido(t)');
hold off;

% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m]', 'FontSize', font_label);
title('Desplazamiento absoluto de la rueda según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion x2 ideal.png'); % Guarda cada gráfico
% Gráfico x3 ideal
figure;
plot(t_pasivo, x3_pasivo, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{3}pasivo(t)');
hold on;
plot(t1, x3_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{3}skyhook(t)');
hold on;
plot(t2, x3_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{3}groundhook(t)');
hold on;
plot(t3, x3_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{3}híbrido(t)');
hold off;

% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m/s]', 'FontSize', font_label);
title('Velocidad absoluta del chasis según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion x3 ideal.png'); % Guarda cada gráfico
% Gráfico x4 ideal
figure;
plot(t_pasivo, x4_pasivo, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{4}pasivo(t)');
hold on;
plot(t1, x4_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{4}skyhook(t)');
hold on;
plot(t2, x4_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{4}groundhook(t)');
hold on;
plot(t3, x4_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'x_{4}híbrido(t)');
hold off;
% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m/s]', 'FontSize', font_label);
title('Velocidad absoluta de la rueda según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion x4 ideal.png'); % Guarda cada gráfico
% Gráfico U ideal
figure;
plot(t1, U_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{skyhook}(t)');
hold on;
plot(t2, U_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{groundhook}(t)');
hold on;
plot(t3, U_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{híbrido}(t)');
hold off;
% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [N]', 'FontSize', font_label);
title('Acción de control según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion U ideal.png');
% Gráfico U vs (x3-x4) ideal
figure;
plot(x1_ideal_skyhook, U_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{skyhook}(t)');
hold on;
plot(x1_ideal_groundhook, U_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{groundhook}(t)');
hold on;
plot(x1_ideal_hibrido, U_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{híbrido}(t)');
hold off;
% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Desplazamiento [m]', 'FontSize', font_label);
ylabel('Amplitud [N]', 'FontSize', font_label);
title('Acción de control vs desplazamiento relativo del chasis respecto a las ruedas', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion U vs x1 ideal.png'); % Guarda cada gráfico
% Gráfico U vs (x3-x4) ideal
figure;
plot(x3_ideal_skyhook-x4_ideal_skyhook, U_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{skyhook}(t)');
hold on;
plot(x3_ideal_groundhook-x4_ideal_groundhook, U_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{groundhook}(t)');
hold on;
plot(x3_ideal_hibrido-x4_ideal_hibrido, U_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'U_{híbrido}(t)');
hold off;
% Estética del gráfico
grid on;
legend('Location', 'best');
xlabel('Velocidad [m/s]', 'FontSize', font_label);
ylabel('Amplitud [N]', 'FontSize', font_label);
title('Acción de control vs velocidad relativa del chasis respecto a las ruedas', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'Comparacion U y (x3-x4) ideal.png'); % Guarda cada gráfico

%% Filtro Kalman
% Extraer datos de la estructura
load('resultados_kalman_discreto.mat')
t_discreto = out.kalman_discreto.time;
x1_kalman_discreto = out.kalman_discreto.signals(1).values;
x2_kalman_discreto = out.kalman_discreto.signals(2).values;
x3_kalman_discreto = out.kalman_discreto.signals(3).values;
x4_kalman_discreto = out.kalman_discreto.signals(4).values;
x1_t_discreto = out.kalman_discreto.signals(5).values;
x2_t_discreto = out.kalman_discreto.signals(6).values;
x3_t_discreto = out.kalman_discreto.signals(7).values;
x4_t_discreto = out.kalman_discreto.signals(8).values;
U_kalman_discreto = out.kalman_discreto.signals(9).values;
load('resultados_kalman.mat')
t = out.kalman.time;
x1_kalman = out.kalman.signals(1).values;
x2_kalman = out.kalman.signals(2).values;
x3_kalman = out.kalman.signals(3).values;
x4_kalman = out.kalman.signals(4).values;
x1_t = out.kalman.signals(5).values;
x2_t = out.kalman.signals(6).values;
x3_t = out.kalman.signals(7).values;
x4_t = out.kalman.signals(8).values;
U_kalman = out.kalman.signals(9).values;
% Crear gráficos comparativos
for i = 1:4
    figure;
    
    % Variables dinámicas
    %x_k = eval(sprintf('x%d_kalman', i)); % Señal discreta
    x_kalman1 = eval(sprintf('x%d_kalman_discreto', i)); % Señal discreta
    x_t = eval(sprintf('x%d_t_discreto', i)); % Señal continua
    
    % Gráfico
    plot(t_discreto, x_t, '-', 'LineWidth', line_wd, 'DisplayName', sprintf('x_{%d}(t)', i)); % Línea continua
    hold on;
    plot(t_discreto, x_kalman1, '--', 'LineWidth', line_wd, 'DisplayName', sprintf('x_{%d}[k]', i)); % Línea continua
    %hold on;
    %plot(t, x_k, '--', 'LineWidth', line_wd, 'DisplayName', sprintf('x_{%d}[k]', i)); % Línea discontinua
    hold off;
    
    % Estética del gráfico
    grid on;
    legend('Location', 'best');
    xlabel('Tiempo [s]', 'FontSize', font_label);
    ylabel('Amplitud [m]', 'FontSize', font_label);
    if i==1 title('Desplazamiento relativo del chasis respecto a la rueda', 'FontSize', font_label + 5);end
    if i==2 title('Desplazamiento relativo de la rueda respecto al terreno', 'FontSize', font_label + 5);end
    if i==3 
        title('Velocidad vertical del chasis', 'FontSize', font_label + 5);
        ylabel('Amplitud [m/s]', 'FontSize', font_label);
    end
    if i==4 
        title('Velocidad vertical de la rueda', 'FontSize', font_label + 5);
        ylabel('Amplitud [m/s]', 'FontSize', font_label);
    end
    set(gca, 'FontSize', font_tick);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
    %saveas(gcf, sprintf('comparacion_x%d.png', i)); % Guarda cada gráfico
end

t_error = out.error.time;
error_x1 = out.error.signals(1).values;
error_dx3 = out.error.signals(2).values;
% Gráfico para error de sensor de desplazamiento lineal
figure;
plot(t_error, error_x1, '-', 'LineWidth', line_wd, 'DisplayName', 'error x_1');
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m]', 'FontSize', font_label);
title('Error de sensor de desplazamiento lineal', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen

% Gráfico para error de acelerometro
figure;
plot(t_error, error_dx3, '-', 'LineWidth', line_wd, 'DisplayName', 'error dx_3');
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m/s^2]', 'FontSize', font_label);
title('Error de acelerómetro', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen

% Gráfico para dx3 de kalman vs dx3 pasivo
figure;
plot(t_pasivo, dx3_pasivo, '-', 'LineWidth', line_wd, 'DisplayName', 'dx_3pasivo');
hold on;
plot(t1, dx3_ideal_skyhook, '-', 'LineWidth', line_wd, 'DisplayName', 'dx_3skyhook');
hold on;
plot(t2, dx3_ideal_groundhook, '-', 'LineWidth', line_wd, 'DisplayName', 'dx_3groundhook');
hold on;
plot(t3, dx3_ideal_hibrido, '-', 'LineWidth', line_wd, 'DisplayName', 'dx_3híbrido');
    hold off;
grid on;
legend('Location', 'best');
xlabel('Tiempo [s]', 'FontSize', font_label);
ylabel('Amplitud [m/s^2]', 'FontSize', font_label);
title('Comparación de la aceleración absoluta del chasis según tipo de control', 'FontSize', font_label + 5);
set(gca, 'FontSize', font_tick);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]); % Fullscreen
%saveas(gcf, 'control_U.png'); % Guarda el gráfico
