codeunit 60101 "Leave Management"
{
    procedure SubmitLeaveRequest(var LeaveRequest: Record "Leave Request")
    var
        LeaveReqEntRec : Record "Leave Request Entry";
    begin
        CheckEntries(LeaveRequest);
        
        LeaveReqEntRec := CreateLeaveReqEntry(LeaveRequest);

        CreateLeaveEntry(LeaveReqEntRec);
        
        Message('Leave Request submitted successfully.');
    end;
    
    procedure CreateLeaveReqEntry(var LeaveRequest : Record "Leave Request") : Record "Leave Request Entry"
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

        CreateLeaveRequestLogEntry(LeaveReqEntRec);

        exit(LeaveReqEntRec);
    end;
    procedure CreateLeaveEntry(var LeaveRequestEntry: record "Leave Request Entry")
    var
        LeaveEntRec : Record "Leave Entry";
        LeavePerRec : Record "Leave Period";
        LeaveReq : Record "Leave Request";
        CurrentDate, EndDate : Date;
        PeriodStartDate, PeriodEndDate : Date;
        NoofdaysPer : Integer;
        currPeriodCode : Code[20];
    begin
        CurrentDate := LeaveRequestEntry."Start Date";
        EndDate := LeaveRequestEntry."End Date";
        repeat
            LeavePerRec.SetFilter("Start Date", '<=%1', CurrentDate);
            if not LeavePerRec.FindLast() then
                Error('No leave period found for date %1', CurrentDate);

            currPeriodCode := LeavePerRec.Code;
            PeriodStartDate := LeavePerRec."Start Date";

            LeavePerRec.SetFilter("Start Date", '>%1', PeriodStartDate);
            if LeavePerRec.FindFirst() then
                PeriodEndDate := LeavePerRec."Start Date" - 1
            else
                PeriodEndDate := EndDate; 

       
            if EndDate < PeriodEndDate then
                PeriodEndDate := EndDate;

            NoOfDaysPer := LeaveReq.CalculateNoofDays(CurrentDate,PeriodEndDate);

            if NoOfDaysPer > 0 then begin
                LeaveEntRec.Init();
                LeaveEntRec."Entry No." := 0;
                LeaveEntRec."Leave Request Entry No." := LeaveRequestEntry."Entry No.";
                LeaveEntRec.Employee := LeaveRequestEntry.Employee;
                LeaveEntRec.Period := currPeriodCode;
                LeaveEntRec."Leave Type" := LeaveRequestEntry."Leave Type";
                LeaveEntRec.Type := Type::Leave;
                LeaveEntRec."Start Date" := CurrentDate;
                LeaveEntRec."End Date" := PeriodEndDate;
                LeaveEntRec."No. of Days" := -NoOfDaysPer;
                LeaveEntRec.Status := LeaveRequestEntry.Status::Requested;
                LeaveEntRec.Insert();
            end;

            CurrentDate := PeriodEndDate + 1;

        until CurrentDate > EndDate;
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

    procedure CheckEntries(var LeaveReq : Record "Leave Request")
    var
        LeaveTypeRec : Record "Leave Type";
        LeaveReqEnt: Record "Leave Request Entry";
    begin
        LeaveReq.TestField(Employee);
        LeaveReq.TestField("Start Date");
        LeaveReq.TestField("No. of Days");
        LeaveReq.TestField("End Date");
        LeaveReq.TestField("Stand-in");

        LeaveTypeRec.Get(LeaveReq."Leave Type");
        if LeaveReq.Comments = '' then begin
            if LeaveReq."Start Date" = LeaveReq."End Date" then
                LeaveReq.Comments := StrSubstNo('%1: %2',LeaveTypeRec.Description,LeaveReq."Start Date")
            else 
            LeaveReq.Comments := StrSubstNo('%1: %2 to %3 : %4 days',LeaveTypeRec.Description,LeaveReq."Start Date",LeaveReq."End Date",LeaveReq."No. of Days");
        end;

        LeaveReqEnt.SetRange(Employee,LeaveReq.Employee);
        LeaveReqEnt.SetRange("Leave Type",LeaveReq."Leave Type");
        LeaveReqEnt.SetFilter(Status,'%1|%2',LeaveReqEnt.Status::Approved,LeaveReqEnt.Status::Requested);
        LeaveReqEnt.SetFilter("Start Date",'<=%1',LeaveReq."End Date");
        LeaveReqEnt.SetFilter("End Date",'>=%1',LeaveReq."Start Date");
        if LeaveReqEnt.FindFirst() then
            Error('You have already applied leaves for these dates.');
    end;

}