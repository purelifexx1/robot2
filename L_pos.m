
function out = L_pos(src, des)
  p = sqrt((des(1,1)-src(1,1))^2 + (des(1,2)-src(1,2))^2 + (des(1,3)-src(1,3))^2);
  pxy = sqrt((des(1,1)-src(1,1))^2 + (des(1,2)-src(1,2))^2);
  dx = des(1,1) - src(1,1);
  dy = des(1,2) - src(1,2);
  dz = des(1,3) - src(1,3);
  x = [dx/p src(1,1)];
  y = [dy/p src(1,2)];
  z = [dz/p src(1,3)];
  out = [x;y;z];
end