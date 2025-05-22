codeunit 60101 "Leave Management"
{
    procedure SubmitLeaveRequest(var LeaveRequest: Record "Leave Request")
    var
        LeaveEntRec : Record "Leave Entry";
    begin
        LeaveEntRec.Init();
        LeaveEntRec."Entry No." := 0;
        LeaveEntRec.Employee := LeaveRequest.Employee;
        LeaveEntRec."Employee Name" := LeaveRequest."Employee Name";
        LeaveEntRec."Leave Type" := LeaveRequest."Leave Type";
        LeaveEntRec."Start Date" := LeaveRequest."Start Date";
        LeaveEntRec."No. of Days" := LeaveRequest."No. of Days";
        LeaveEntRec.Comments := LeaveRequest.Comments;
        LeaveEntRec."Stand-in" := LeaveRequest."Stand-in";
        LeaveEntRec."Request Date" := Today();
        LeaveEntRec."Request Time" := Time();
        LeaveEntRec.Insert();

        Message('Leave Request submitted successfully.');
    end;
}