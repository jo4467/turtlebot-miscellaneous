function turtlebotTurnAngle(theta_desired, velocityPublisher, odometrySubscriber)

% default settings for closed-loop(ish) turns
rotation_speed = 0.5; %no idea the units
theta_error_tolerance = 1;  %degree

% get the current angle with no offset
odometryState = getTurtlebotOdometry(odometrySubscriber, 0);
theta_offset = odometryState(3);
% use existing theta as the offset angle (new theta should read 0)
odometryState = getTurtlebotOdometry(odometrySubscriber, theta_offset);
theta = odometryState(3);

% determine initial error in theta measurement
theta_error = abs(theta_desired - theta);

% turn toward the desired theta at default speed until pointing in the
% right direction
while theta_error > theta_error_tolerance
    % set turn speed with correct turn direction
    turnSpeed = sign(theta_desired - theta)*rotation_speed;
    turtlebotSendSpeed(0, turnSpeed, velocityPublisher)
    
    % check current odometry again and calculate error
    odometryState = getTurtlebotOdometry(odometrySubscriber, theta_offset);
    theta = odometryState(3);
    theta_error = abs(theta_desired - theta);
    
    % short pause so we don't clog the system
    pause(0.005)
end

turtlebotStop(velocityPublisher);