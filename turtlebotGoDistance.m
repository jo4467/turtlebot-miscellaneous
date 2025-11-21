function turtlebotGoDistance(distance, velocityPublisher, odometrySubscriber)

% set default speed
forwardSpeed = 0.3;

%odometry
odometryStatebegin = getTurtlebotOdometry(odometrySubscriber, 0);

difference = [0, 0];
while sqrt(difference(1).^2 + difference(2).^2) < abs(distance)
    % send velocity command
    forwardSpeed = sign(distance)*abs(forwardSpeed);
    state = getTurtlebotOdometry(odometrySubscriber, 0) - odometryStatebegin
    turtlebotSendSpeed(forwardSpeed, -1*state(3)*0.3, velocityPublisher);
    difference = getTurtlebotOdometry(odometrySubscriber, 0) - odometryStatebegin;
end

turtlebotStop(velocityPublisher);

