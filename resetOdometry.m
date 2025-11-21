function resetOdometry()
    resetPublisher = rospublisher('/reset');
    resetMessage = rosmessage(resetPublisher);
    send(resetPublisher, resetMessage);
end

