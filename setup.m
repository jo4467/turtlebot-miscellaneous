%% Initialize Turtlebot connection through ROS
turtlebot_ip = '192.168.0.188';%
rosinit(turtlebot_ip);

rostopic list

%% Get Publishers and Subscribers
velocityPublisher = rospublisher('/cmd_vel');
odometrySubscriber = rossubscriber('/odom');
velocityMessage = rosmessage(velocityPublisher)
odometryMessage = rosmessage(odometrySubscriber)
