function [Mp ts jixiao_time jixiao_value] = get_evalua(X_result,Time_result)
theta = X_result(:,1);
countxiao = 1;
for i = 2:size(theta,1)-1
      if theta(i)<theta(i-1)&&theta(i)<theta(i+1)
       jixiao_time(countxiao,1) = Time_result(i);
       jixiao_value(countxiao,1) = theta(i);
       countxiao = countxiao+1;
      end
end
if countxiao>1
    Mp = abs(jixiao_value(1));
    u=find(abs(jixiao_value)<=1e-2);
     if size(u,1)>1
       ts = jixiao_time(u(1));
    else
       ts = 2;
    end 
else
    Mp = 0.1;
    ts = 2;
end

end