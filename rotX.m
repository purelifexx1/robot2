
function output = rotX(first, second, pos, t_start, t_stop)
  first = sin(degtorad(first));
  second = sin(degtorad(second));
  N = 30;
  time_stamp = linspace(t_start, t_stop, N);
  K = (second - first)/(t_stop - t_start);
  C = first - K*t_start;
  array = double.empty;
  for time = time_stamp
      out_theta = inverse(pos(1,1), pos(1,2), pos(1,3), K*time+C);
      out_theta = out_theta*180/pi;
      out_theta(1,2) = out_theta(1,2) - 79.3803;
      out_theta(1,3) = out_theta(1,3) + 79.3803;
      out_theta(1,4) = -out_theta(1,4);
      array = [array; [time out_theta]];
  end
  output = array;
end