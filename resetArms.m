function[] = resetArms(motors)
%% Reset angles
    mARight = motors(2,1);
    mBUp = motors(2,2);
    mCUp = motors(2,3);
    
    data = mARight.ReadFromNXT();
    pos  = data.Position;
    mARight.TachoLimit = pos;
    mARight.SendToNXT();
 
    data = mCUp.ReadFromNXT();
    pos  = data.Position;
    mCUp.TachoLimit = pos;
    mCUp.SendToNXT();
 
    data = mBUp.ReadFromNXT();
    pos  = data.Position;
    mBUp.TachoLimit = -1 * pos;
    mBUp.SendToNXT();
   
    mARight.WaitFor();
    mBUp.WaitFor();
    mCUp.WaitFor();
    
    mARight.Stop('off');
    mBUp.Stop('off');
    mCUp.Stop('off');  
end 