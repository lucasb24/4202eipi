function [angles_new] = moveTo(x, y, z, angles, motors)
    a = 164; % x offset (mm)
    b = 80; % y offset (mm)
    c = 82; % z offset (mm)

    M = 158; % arm 1 length (mm)
    N = 72; % arm 2 length (mm)
    P = 112; % pen length (mm)    
    alpha = 135; % pen degree constant (degrees)

    x = 32*x-16; % Convert co-ordinate to mm
    y = 32*y-16; % Convert co-ordinate to mm
    z = 19*z; % Convert co-ordinate to mm

    O = sqrt(N^2 + P^2 - 2*N*P*cosd(alpha)); % Calculate effective N
    l = sqrt((y+b)^2+(x-a)^2);
    r = sqrt(l^2+(z-c)^2);
    phi2 = atand((z-c)/l);
    beta2 = acosd((M^2+r^2-O^2)/(2*M*r)) ;
    theta2 = beta2 + phi2;
    phi3 = asind(P*sind(alpha)/O);
    beta3 = asind(r*sind(beta2)/O);
    theta3 = phi3 + beta3;
    
    if x==a 
        theta1 = 0;
    elseif x>a
        theta1 = atand((y+b)/(x-a)) - 90;
    else
        theta1 = 90 - atand((y+b)/(a-x));
    end
    
    theta3 = theta3 + 5 ;
    
    theta2 = 90 - theta2;
    theta3 = 180 - theta3;
    
    % Return the new angles
    angles_new = [theta1, theta2, theta3];
    
    % Compensate for angles that the motors are already pointing at
    theta1 = theta1 - angles(1);
    theta2 = theta2 - angles(2);
    theta3 = theta3 - angles(3);
    
    % Move the motors
    moveMotors([theta1, theta2, theta3], motors);
end