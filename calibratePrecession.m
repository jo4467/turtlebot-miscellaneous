function precessionRate = calibratePrecession(odometrySubscriber)

timeSpan = 0.3;
timeInterval = 0.01;
n_timeSteps = timeSpan/timeInterval;

theta = [];
for i = 1:n_timeSteps
    state = getTurtlebotOdometry(odometrySubscriber, theta_offset);
    theta(end+1) = state(3);
    pause(0.01);
end
precessionRate = mean(diff(theta))/timeInterval;
