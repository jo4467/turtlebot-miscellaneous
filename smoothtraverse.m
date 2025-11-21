function smoothtraverse(goal, startpoint, gpssub, odometrySubscriber, ke, ka, kb, velocityPublisher)
        odo = getTurtlebotOdometry(odometrySubscriber, 0);
        offset = odo(3);
    while true
        gps = receive(gpssub);
        odo = getTurtlebotOdometry(odometrySubscriber, 0);
        gps.XM
        gps.YM
        rho = sqrt((goal(1)-gps.XM).^2 + (goal(2)-gps.YM).^2);
        theta = wrapTo180(odo(3) - offset);
        alpha = -wrapTo180(rad2deg(atan2((goal(2)-gps.YM), (goal(1)-gps.XM)))+90) - theta;
        beta = -((theta + alpha) ); %- goal(3)
        %check
        if rho<0.2 %%&& beta<5
            break;
        end
        v = ke*rho;
        if v>0.3
            v = 0.3;
        end
        w = ka*alpha + kb*beta;
        if w>1
            w = 1;
        end
        if w < -1
            w = -1;
        end
        w
        turtlebotSendSpeed(v, w, velocityPublisher)
    end
transformation = [1, 0, 0; 0, 0, -1; 0, 1, 0];
%start: (2,5,0)in feet = [1.252, 5.636, 0]
%end: (6,15,45)in feet = [0.303, 3.559, 45]
end

