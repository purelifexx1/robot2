% p1 = [2 2 2];
% p2 = [-3 5 0];
% p3 = [1 6 5];
function [output, direction, start_point, circle_configure, length] = C_pos_start(p1, p2, p3)
p12 = (p1 - p2)/norm(p1 - p2); p13 = (p1 - p3)/norm(p1-p3);
x_axis = p12;
z_axis = cross(p12, p13); z_axis = z_axis/norm(z_axis);
y_axis = cross(z_axis, x_axis); y_axis = y_axis/norm(y_axis);
homo = [x_axis 0; y_axis 0; z_axis 0; p1 1].';
output = homo;
%homo\ inverse
p1_1 = (homo\[p1.';1]);
p2_1 = homo\[p2.';1];
p3_1 = homo\[p3.';1];
c_vt = [2*p1_1(1,1) 2*p1_1(2,1) -1;2*p2_1(1,1) 2*p2_1(2,1) -1;2*p3_1(1,1) 2*p3_1(2,1) -1]\[p1_1(1,1)^2+p1_1(2,1)^2;p2_1(1,1)^2+p2_1(2,1)^2;p3_1(1,1)^2+p3_1(2,1)^2];
R = sqrt(c_vt(1,1)^2 + c_vt(2,1)^2 - c_vt(3,1));
a = c_vt(1,1); b = c_vt(2,1);
p1_c = [p1_1(1,1)-a p1_1(2,1)-b];
p2_c = [p2_1(1,1)-a p2_1(2,1)-b];
p3_c = [p3_1(1,1)-a p3_1(2,1)-b];
circle_configure = [a b R];
an1 = atan2(p1_c(1,2), p1_c(1,1));
if an1 < 0 
    an1 = 2*pi + an1;
end
an2 = atan2(p2_c(1,2), p2_c(1,1));
if an2 < 0
    an2 = 2*pi + an2;
end
an3 = atan2(p3_c(1,2), p3_c(1,1));
if an3 < 0
    an3 = 2*pi + an3;
end
if an2 > an1
    direction = 'anti_cl';
else
    direction = 'cl';
end
start_point = an1;
length = abs(an3-an1)*R;
end

