codeunit 60101 "Leave Management"
{
    procedure SubmitLeaveRequest(var LeaveRequest: Record "Leave Request")
    var
        LeaveReqEntRec : Record "Leave Request Entry";
    begin
        LeaveReqEntRec.Init();
        LeaveReqEntRec."Entry No." := 0;
        LeaveReqEntRec.Employee := LeaveRequest.Employee;
        LeaveReqEntRec."Employee Name" := LeaveRequest."Employee Name";
        LeaveReqEntRec."Leave Type" := LeaveRequest."Leave Type";
        LeaveReqEntRec."Start Date" := LeaveRequest."Start Date";
        LeaveReqEntRec."No. of Days" :=  LeaveRequest."No. of Days";
        LeaveReqEntRec."End Date" := LeaveRequest."End Date";
        LeaveReqEntRec.Comments := LeaveRequest.Comments;
        LeaveReqEntRec."Stand-in" := LeaveRequest."Stand-in";
        LeaveReqEntRec."Request Date" := Today;
        LeaveReqEntRec."Request Time" := Time;
        LeaveReqEntRec.Insert();
        
        CreateLeaveEntry(LeaveReqEntRec);
        CreateLeaveRequestLogEntry(LeaveReqEntRec);

        Message('Leave Request submitted successfully.');
    end;
    procedure CreateLeaveEntry(var LeaveRequestEntry: record "Leave Request Entry")
    var
        LeaveEntRec : Record "Leave Entry";
        LeavePerRec : Record "Leave Period";
    begin
        LeavePerRec.SetFilter("Start Date", '<=%1', LeaveRequestEntry."Start Date");
        if not LeavePerRec.FindLast() then
            Error('No Leave period found for the selected date.');
        LeaveEntRec.Init();
        LeaveEntRec."Entry No." := 0;
        LeaveEntRec."Leave Request Entry No." := LeaveRequestEntry."Entry No.";
        LeaveEntRec.Employee := LeaveRequestEntry."Employee";
        LeaveEntRec.Period := LeavePerRec.Code;
        LeaveEntRec."Leave Type" := LeaveRequestEntry."Leave Type";
        LeaveEntRec.Type := Type::Leave;
        LeaveEntRec."Start Date" := LeaveRequestEntry."Start Date";
        LeaveEntRec."End Date" := LeaveRequestEntry."End Date";
        LeaveEntRec."No. of Days" := - LeaveRequestEntry."No. of Days";
        LeaveEntRec.Status := LeaveRequestEntry.Status::Requested;
        LeaveEntRec.Insert();
    end;
    procedure CreateLeaveRequestLogEntry(var LeaveReqEnt : Record "Leave Request Entry")
    var
        LeaveReqLog : Record "Leave Request Log";
    begin
        LeaveReqLog.Init();
        LeaveReqLog."Entry No." := 0;
        LeaveReqLog."Leave Request Entry No." := LeaveReqEnt."Entry No.";
        LeaveReqLog.Date := Today;
        LeaveReqLog.Comment := LeaveReqEnt.Comments;
        LeaveReqLog.User := LeaveReqEnt.Employee;
        LeaveReqLog.Time := Time;
        LeaveReqLog.Insert();
    end;
}