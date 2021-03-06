function out = middle_hands(boxes)
    % out returns an array of centre points for each hand that was detected 
    % boxes is an array bounding boxes of the hands detected
    % ( boxes = [x y width heigh] )
    numHands = size(boxes, 1);
    out = zeros(numHands, 2);
    
    for i = 1:numHands
        
       mid_x = boxes(i,1) + boxes(i,3)/2;
       mid_y = boxes(i,2) + boxes(i,4)/2;
       out(i, 1) = mid_x;
       out(i, 2) = mid_y;
   
    end
end