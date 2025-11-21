function turtlebotGoToWaypoint(start, endpoint, velocityPublisher, odometrySubscriber, lidarsub)
    goalthresh = 0.05;
    obstaclethresh = 0.1;
    rate = rosrate(10);
    while true
        %get position
        state = getTurtlebotOdometry(odometrySubscriber(), 0);
        dx = endpoint(1) - state(1);
        dy = endpoint(2) - state(2);
        goalDist = hypot(dx,dy);
        goalAngle = atan2(dy, dx);

        %stop condition
        if goalDist < goalthresh
            turtlebotStop(velocityPublisher);
            break;
        end
            
        %getlidar
        lidarState = receive(lidarsub, 1);
        scanRanges = lidarState.Ranges;
        scanAngles = linspace(lidarState.AngleMin, lidarState.AngleMax, numel(scanRanges));

        %front facing portion
        frontIdx = abs(scanAngles) < deg2rad(15);
        frontDist = min(scanRanges(frontIdx), [], 'omitnan');

        if frontDist < obstaclethresh
            % Obstacle too close — turn left until clear
            disp('Obstacle detected! Turning left...');
            turtlebotSendSpeed(0, 0.4, velocityPublisher);
            while true
                lidarState = receive(lidarsub, 1);
                frontDist = min(lidarState.Ranges(frontIdx), [], 'omitnan');
                if frontDist > obstaclethresh
                    break;
                end
                pause(0.1);
            end
            turtlebotStop(velocityPublisher);
        else
            % Move toward goal
            angleError = wrapToPi(goalAngle - state(3));
            turtlebotSendSpeed(0.15, 0.5*angleError, velocityPublisher)
        end
        waitfor(rate);
    end
end
