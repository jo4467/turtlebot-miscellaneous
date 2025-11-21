function turtlebotStop(velocityPublisher)

% send a zero speed a few times just to make sure the bot get it
for i = 1:5
    turtlebotSendSpeed(0, 0, velocityPublisher)
    pause(0.01);
end