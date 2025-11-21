function state = getTurtlebotOdometry(odometrySubscriber, theta_offset)

% retrieve the odometry data from the ROS subscriber
odomState = receive(odometrySubscriber);
% convert the quaternion nonsense to rotation about Z axis
quat = odomState.Pose.Pose.Orientation;
angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
theta_raw = rad2deg(angles(1));
% account for any theta offset and return theta in range of +/- 180
theta = mod((theta_raw - theta_offset) + 180, 360)-180;
% package up into X, Y, theta
state = [
    odomState.Pose.Pose.Position.X;
    odomState.Pose.Pose.Position.Y;
    theta
    ];

