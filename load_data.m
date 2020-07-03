 %teach pendent
 kq = double.empty;
%  kq = movL([0 0.1 0.02], [0 0.1 0.05], -90, 0, 1);
kq = [kq; movC([0 0.1 0.05],[0.1 0 0.12],[0 -0.1 0.05],-90,0,3)];
 %kq = [kq; movC_smooth([0 0.1 0.05],[0.1 0 0.12],[0 -0.1 0.05],-90,0,3,0.18)];
%  kq = [kq; movL([0 -0.1 0.05], [0 -0.1 0.02], -90, 4, 5)];
%  kq = [kq; movL([0 -0.1 0.02], [0 -0.1 0.05], -90, 5, 6)];
%  kq = [kq; movC([0 -0.1 0.05],[0.1 0 0.12],[0 0.1 0.05],-90,6,9)];
%  kq = [kq; movL([0 0.1 0.05], [0 0.1 0.02], -90, 9, 10)];

 T = 4;
 %load and run
 [h,~] = size(kq);
 theta1_dot = double.empty;
 theta2_dot =  double.empty;
 theta3_dot =  double.empty;
 theta4_dot =  double.empty;

 for run = 1:h
     if mod(run,30) == 1
         theta1_dot = [theta1_dot; [kq(run,1) 0]];
         theta2_dot = [theta2_dot; [kq(run,1) 0]];
         theta3_dot = [theta3_dot; [kq(run,1) 0]];
         theta4_dot = [theta4_dot; [kq(run,1) 0]];
     else
         theta1_dot = [theta1_dot; [kq(run,1) (kq(run,2)-kq(run-1,2))/(kq(run,1)-kq(run-1,1))]];
         theta2_dot = [theta2_dot; [kq(run,1) (kq(run,3)-kq(run-1,3))/(kq(run,1)-kq(run-1,1))]];
         theta3_dot = [theta3_dot; [kq(run,1) (kq(run,4)-kq(run-1,4))/(kq(run,1)-kq(run-1,1))]];
         theta4_dot = [theta4_dot; [kq(run,1) (kq(run,5)-kq(run-1,5))/(kq(run,1)-kq(run-1,1))]];
     end
   
 end

theta1 = [kq(:,1) kq(:,2)];
theta2 = [kq(:,1) kq(:,3)];
theta3 = [kq(:,1) kq(:,4)];
theta4 = [kq(:,1) kq(:,5)];

for ii = 1:1
sim('Assem2.slx');
end