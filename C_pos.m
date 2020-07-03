
function output = C_pos(homo, direction, start_point, circle_configure, des)
  if direction == 'anti_cl'
    des_angle = start_point + des/circle_configure(1, 3);
  else
    des_angle = start_point - des/circle_configure(1, 3);  
  end
  x_c = circle_configure(1,3)*cos(des_angle);
  y_c = circle_configure(1,3)*sin(des_angle);
  x = x_c + circle_configure(1,1);
  y = y_c + circle_configure(1,2);
  output = homo*[x;y;0;1];
end