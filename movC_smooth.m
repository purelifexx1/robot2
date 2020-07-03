
function output = movC_smooth(first, second, third, r31,t_start,t_stop,vc)
  r31 = sin(degtorad(r31));
  N = 60;
  [homo, direction, start_point, circle_configure, distance] = C_pos_start(first, second, third);
  T = t_stop - t_start;
  if vc < (distance/T)*1.2
      vc = (distance/T)*1.2;
  else if vc > (distance/T)*1.8
      vc = (distance/T)*1.8;
  end
  ta= (vc*T - distance)/(2*vc);
  amax = vc/ta;
  t_const = T- 4*ta;
  
  t0 = 0; t1 = ta;
  vt_up_acc = ([t0^3 t0^2 t0 1; 3*t0^2 2*t0 1 0; 6*t0 2 0 0; 6*t1 2 0 0]\[0;0;0;amax]).';
  s1 = vt_up_acc*[t1^3;t1^2;t1;1];
  v1 = vt_up_acc*[3*t1^2;2*t1;1;0];

  t0 = t1; t1 = t1 + ta;
  vt_up_dec = ([t0^3 t0^2 t0 1; 3*t0^2 2*t0 1 0; 6*t0 2 0 0; 6*t1 2 0 0]\[s1;v1;amax;0]).';
  s2 = vt_up_dec*[t1^3;t1^2;t1;1]; v2 = vc;

  t0 = t1; t1 = t1 + t_const;
  vt_const = ([t0 1;1 0]\[s2 ; v2]).';
  s3 = vt_const*[t1;1];
  v3 = vc;

  t0 = t1;
  t1 = t1 + ta;
  vt_down_acc = ([t0^3 t0^2 t0 1; 3*t0^2 2*t0 1 0; 6*t0 2 0 0; 6*t1 2 0 0]\[s3;v3;0;-amax]).';
  s4 = vt_down_acc*[t1^3;t1^2;t1;1];
  v4 = vt_down_acc*[3*t1^2;2*t1;1;0];
  
  t0 = t1; t1 = T;
  vt_down_dec = ([t0^3 t0^2 t0 1; 3*t0^2 2*t0 1 0; 6*t0 2 0 0; 6*t1 2 0 0]\[s4;v4;-amax;0]).';

  time_stamp = linspace(t_start, t_stop, N);
  pos = double.empty;
  array = double.empty;
  array1 = double.empty;
  array2 = double.empty;
  for time = time_stamp 
     if time < ta
          im_pos = vt_up_acc*[time^3;time^2;time;1];  
          im_pos1 = vt_up_acc*[3*time^2;2*time;1;0]; 
          im_pos2 = vt_up_acc*[6*time;2;0;0];  
     elseif time >= ta && time < 2*ta
         im_pos = vt_up_dec*[time^3;time^2;time;1];
          im_pos1 = vt_up_dec*[3*time^2;2*time;1;0];  
           im_pos2 = vt_up_dec*[6*time;2;0;0];  
     elseif time >= 2*ta && time < 2*ta+t_const
         im_pos = vt_const*[time;1]; 
          im_pos1 = vt_const*[1;0]; 
          im_pos2 = vt_const*[0;0];
     elseif time >= 2*ta+t_const && time < 3*ta+t_const
         im_pos = vt_down_acc*[time^3;time^2;time;1];
          im_pos1 = vt_down_acc*[3*time^2;2*time;1;0];  
           im_pos2 = vt_down_acc*[6*time;2;0;0];  
     elseif time >= 3*ta+t_const && time < T
         im_pos = vt_down_dec*[time^3;time^2;time;1];
          im_pos1 = vt_down_dec*[3*time^2;2*time;1;0];  
           im_pos2 = vt_down_dec*[6*time;2;0;0];  
     end 
     cordinate = C_pos(homo, direction, start_point, circle_configure, im_pos).';
     out_theta = inverse(cordinate(1,1), cordinate(1,2), cordinate(1,3),r31); 
     out_theta = out_theta*180/pi;
     out_theta(1,2) = out_theta(1,2) - 79.3803;
     out_theta(1,3) = out_theta(1,3) + 79.3803;
     out_theta(1,4) = -out_theta(1,4);
     pos = [pos; [time out_theta]];
     array = [array im_pos];
     array1 = [array1 im_pos1];
     array2 = [array2 im_pos2];
  end
  output = pos;
  figure
  plot(time_stamp, array);
  figure
    plot(time_stamp, array1);
  figure
    plot(time_stamp, array2);

end