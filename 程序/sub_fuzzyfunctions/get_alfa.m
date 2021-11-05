function alfa = get_alfa(rule,theta,d_theta,width_x,center_x,normal)
    for i_x1 = 1:5
        for i_x2 = 1:5
            alfa(i_x1,i_x2) = min(rule{i_x1}(theta/normal.theta,width_x,center_x),rule{i_x2}(d_theta/normal.d_theta,width_x,center_x));
        end
    end
end