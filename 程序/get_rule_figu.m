function  get_rule_figu(center_x,width_x,flag)
addpath ./sub_gafunctions
addpath ./sub_fuzzyfunctions


% NL NS ZO PS PL
 Num_ux = 1e3;   
 u_x =linspace(-1,1,Num_ux);
 rule ={@NL @NS @ZO @PS @PL};
for i=1:5
      for j = 1:Num_ux
        miu_U_part(i,j) = rule{i}(u_x(j),width_x,center_x);
      end
end




 if flag == 0
     figure(20)
     hold on
     for i=1:5
         plot(u_x,miu_U_part(i,:),'.-')
     end
     hold off
     xlabel('x')
     ylabel('\mu')
      title('优化前隶属度函数');
     frame1 = getframe(gcf);
   imwrite(frame1.cdata,'隶属度函数initi.jpg')
 else
     figure(21)
     hold on
     for i=1:5
         plot(u_x,miu_U_part(i,:),'.-')
     end
     hold off
     xlabel('x')
     ylabel('\mu')
      title('优化后隶属度函数');
     frame1 = getframe(gcf);
  imwrite(frame1.cdata,'隶属度函数optimi.jpg')
 end











