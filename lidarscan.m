lidarsub = rossubscriber('/scan');
lidarMessage = rosmessage(lidarsub);
lidarState = receive(lidarsub)