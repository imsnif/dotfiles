systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target;
systemctl suspend;
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target;

