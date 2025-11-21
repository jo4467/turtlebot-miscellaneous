function turtlebotGoDistance(distance, velocityPublisher, odometrySubscriber)

% set default speed
forwardSpeed = 0.3;

%odometry
odometryStatebegin = getTurtlebotOdometry(odometrySubscriber, 0);

% we're just doing to do this by timing for now...
% get the time to run forward (use 0.01s intervals for sending)
% timeInterval = 0.01;
% totalTime = abs(distance)/forwardSpeed;
% n_timeSteps = floor(totalTime/timeInterval);

% run at speed for given time
% for i = 1:n_timeSteps
%     % send velocity command
%     forwardSpeed = sign(distance)*abs(forwardSpeed);
%     turtlebotSendSpeed(forwardSpeed, 0, velocityPublisher)
%     % pause for timing
%     pause(timeInterval);
% end
difference = [0, 0];
while sqrt(difference(1).^2 + difference(2).^2) < abs(distance)
    % send velocity command
    forwardSpeed = sign(distance)*abs(forwardSpeed);
    state = getTurtlebotOdometry(odometrySubscriber, 0) - odometryStatebegin
    turtlebotSendSpeed(forwardSpeed, -1*state(3)*0.3, velocityPublisher);
    difference = getTurtlebotOdometry(odometrySubscriber, 0) - odometryStatebegin;
end

turtlebotStop(velocityPublisher);
