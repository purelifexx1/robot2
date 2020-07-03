T = 0;
k = 1;
N = 50000;
delta_t = 0.01;

pos  = zeros(N,1);
acc = zeros(N,1);
vel = zeros(N,1);


time = 0:delta_t:(N-1)*delta_t; % Time array
acc(1) = 1;

vmax = 15;
amax = 0.1;
h = 1000;

if ( h < vmax^2/amax)
    disp("invalid")
    vmax = sqrt(h*amax)
end 
tf = vmax/amax
t_full = (h*amax + vmax^2)/(amax*vmax)

while( T <= tf)

     pos(k+1) = pos(k) + vel(k)*delta_t + acc(k)*delta_t^2/2;
     vel(k+1) = vel(k) + acc(k)*delta_t;
    
      acc(k+1) = amax;
    
%      while(vel(k) < 10)
%         acc(k+1) = 1;
%     end
     T  = T + delta_t;
     k = k +1;%

end
  while(  T <= (t_full - tf))
       pos(k+1) = pos(k) + vel(k)*delta_t + acc(k)*delta_t^2/2;
       vel(k+1) = vel(k) + acc(k)*delta_t;
       acc(k+1) = 0;
          T  = T + delta_t;
       k = k +1;% 
  end
  while( T <= t_full)
       pos(k+1) = pos(k) + vel(k)*delta_t + acc(k)*delta_t^2/2;
       vel(k+1) = vel(k) + acc(k)*delta_t;
       
       acc(k+1) = -amax;
        T  = T + delta_t;
       k = k +1;
%  
  end
figure;
subplot(3,1,1);
hold on;grid on;
plot(time,pos(1:N),'g');
legend( 'estimated');
title('Pos');

subplot(3,1,2);
hold on;grid on;
plot(time,vel(1:N),'g');
title('Vel');

subplot(3,1,3);
hold on;grid on;
plot(time,acc(1:N),'g');
legend('estimated');
title('Acc');