
function out = movC(first, second, third, r31, t_start, t_stop)
  r31 = sin(degtorad(r31));
  N = 30;
  [homo, direction, start_point, circle_configure, distance] = C_pos_start(first, second, third);
  T = t_stop - t_start;
  t_up_down = 0.2*T; t_const = 0.6*T; 
  vc = distance/(t_up_down + t_const);
  s_up_down = vc*t_up_down/2;
  s_const = vc*t_const;
  t0 = t_start; t1 = t0 + t_up_down; t2 = t1 + t_const; t3 = t_stop;
  s0 = 0; s1 = s_up_down; s2 = s1 + s_const; s3 = distance; 
  v0 = 0; v1 = vc; v2 = vc; v3 = 0;
  vt_up = ([t0^2 t0 1; 2*t0 1 0; 2*t1 1 0]\[s0;v0;v1]).';
  vt_const = ([t1 1;1 0]\[s1 ; vc]).';
  vt_down = ([t2^2 t2 1; 2*t2 1 0; 2*t3 1 0]\[s2;v2;0]).';
  time_stamp = linspace(t_start, t_stop, N);
  array = double.empty;
  dis = double.empty;
  veloc = double.empty;
  acce = double.empty;
  for time = time_stamp
     if time < t1
          im_pos = vt_up*[time^2;time;1];  
          dis = [dis vt_up*[time^2;time;1]];
          veloc = [veloc vt_up*[2*time;1;0]];
          acce = [acce vt_up*[2;0;0]];
     elseif time >= t1 && time < t2
          im_pos = vt_const*[time;1];
          dis = [dis vt_const*[time;1]];
          veloc = [veloc vt_const*[1;0]];
          acce = [acce vt_const*[0;0]];
     elseif time >= t2
          im_pos = vt_down*[time^2;time;1];   
          dis = [dis vt_down*[time^2;time;1]];
          veloc = [veloc vt_down*[2*time;1;0]];
          acce = [acce vt_down*[2;0;0]];
     end 
     cordinate = C_pos(homo, direction, start_point, circle_configure, im_pos).';
     out_theta = inverse(cordinate(1,1), cordinate(1,2), cordinate(1,3),r31); 
     out_theta = out_theta*180/pi;
     out_theta(1,2) = out_theta(1,2) - 79.3803;
     out_theta(1,3) = out_theta(1,3) + 79.3803;
     out_theta(1,4) = -out_theta(1,4);
     array = [array; [time out_theta]];      
  end
  out = array;
  figure
  plot(time_stamp, dis);
  figure
  plot(time_stamp, veloc);
  figure
  plot(time_stamp, acce);
end

