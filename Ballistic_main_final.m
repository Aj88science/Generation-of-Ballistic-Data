close all
clear all

g = 9.8;
rho = 1.225;
mass = 50000.0;
surface_area = 0.5;
v0 = 5000;
phi = 45*pi/180;
theta = 201*pi/180;

dt = 0.1;
i = 1;
t(i) = 0;

x0(i) = 0;
y0(i) = 0;
z0(i) = 0;

vx(i) = v0 * cos(phi) * sin(theta);
vy(i) = v0 * cos(theta) * cos(phi);
vz(i) = v0 * sin(phi);
v_total(i) = sqrt(vx(i)^2 + vy(i)^2 + vz(i)^2);

ax(i) = -(0.5 * rho * surface_area) * v0 * vx(i) / mass;
ay(i) = -(0.5 * rho * surface_area) * v0 * vy(i) / mass;
az(i) = -(0.5 * rho * surface_area) * v0 * vz(i) / mass - g;
acc_total(i) =  sqrt(ax(i)^2 + ay(i)^2 + az(i)^2);

gr(i) = sqrt(x0(i)^2 + y0(i)^2);
threshold = 100;

while(threshold > 0)
    i = i + 1;
    t(i) = t(i - 1) + dt;
    
    vx(i) = vx(i-1) + ax(i-1)*dt;
    vy(i) = vy(i-1) + ay(i-1)*dt;
    vz(i) = vz(i-1) + az(i-1)*dt;
    v_total(i) = sqrt(vx(i)^2 + vy(i)^2 + vz(i)^2);
    
    ax(i) = -(0.5 * rho * surface_area) * v_total(i) * vx(i) / mass;
    ay(i) = -(0.5 * rho * surface_area) * v_total(i) * vy(i) / mass;
    az(i) = -(0.5 * rho * surface_area) * v_total(i) * vz(i) / mass - g;
    acc_total(i) =  sqrt(ax(i)^2 + ay(i)^2 + az(i)^2);
    
    x0(i) = x0(i-1) + vx(i-1)*dt + 0.5*ax(i-1)*dt^2;
    y0(i) = y0(i-1) + vy(i-1)*dt + 0.5*ay(i-1)*dt^2;
    z0(i) = z0(i-1) + vz(i-1)*dt + 0.5*az(i-1)*dt^2;
    
    gr(i) = sqrt(x0(i)^2 + y0(i)^2);
    
    threshold = z0(i);
end

xe = 13*randn(1, length(t));
ye = 25*randn(1, length(t));
ze = 30*randn(1, length(t));

 figure;
    subplot(2, 1, 1);
    plot(t, ax, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t, ay, 'r--', 'LineWidth', 1.5);
    plot(t, az, 'g-.', 'LineWidth', 1.5);
    hold off;
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    legend('ax', 'ay', 'az');
    grid on;

    subplot(2, 1, 2);
    plot(t, vx, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t, vy, 'r--', 'LineWidth', 1.5);
    plot(t, vz, 'g-.', 'LineWidth', 1.5);
    hold off;
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    legend('vx', 'vy', 'vz');
    grid on;

    % 3D plot of the motion trajectory
    figure;
    plot3(x0, y0, z0, 'LineWidth', 1.5);
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    title('Motion Trajectory');
    grid on;
    
    figure;
    hold on;
    grid on;
    plot(gr, z0, 'LineWidth', 1.5);
    xlabel('Range(m)');
    ylabel('Height(m)');
    
    figure;
    hold on;
    grid on;
    plot(x0, y0, 'LineWidth', 1.5);
    xlabel('X(m)');
    ylabel('Y(m)');
    
    figure;
    hold on;
    grid on;
    plot(t, v_total, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('Velocity(m/s)');
    
    figure;
    hold on;
    grid on;
    plot(t, acc_total, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('acc(m/s^2)');
    
    figure;
    hold on;
    grid on;
    plot(t, xe, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('noise_x');
    
    figure;
    hold on;
    grid on;
    plot(t, ye, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('noise_y');
    
    figure;
    hold on;
    grid on;
    plot(t, ze, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('noise_z');
    
    figure;
    hold on;
    grid on;
    plot(t, x0, 'LineWidth', 1.5);
    plot(t, xe, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('X');
    
    fd = fopen('ballistic_data.dat','w');
    for j = 1:length(t)
       mx(j) = x0(j) + xe(j);
       my(j) = y0(j) + ye(j);
       mz(j) = z0(j) + ze(j);
       fprintf(fd, '%f %f %f %f %f %f %f %f %f %f %f %f %f \n', t(j), x0(j), y0(j), z0(j), vx(j), vy(j), vz(j), ax(j), ay(j), az(j), mx(j), my(j), mz(j));
     
    end
    fclose(fd);
    
     figure;
    hold on;
    grid on;
    plot(t, x0, 'LineWidth', 1.5);
    plot(t, mx, 'LineWidth', 1.5);
    xlabel('t(sec)');
    ylabel('X');
    
    
    