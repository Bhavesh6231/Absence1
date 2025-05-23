table 60101 "Leave Request"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = Employee, "Employee Name";
    
    fields
    {
        field(1; Employee; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Editable = false;
        }
        field(3;"Employee Name";Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No."= field(Employee)));
            Editable = false;
        }
        field(4; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Type";
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:1;
            MinValue = 0.5;
        }
        field(7; Comments; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Stand-in"; Code[20])              
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        // field(9; "Leave Entitlement Al"; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("Leave Entitlement" where("Leave Type" = const('AL')));
        // }  
        // field(10; "Leave Entitlement OL"; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("Leave Entitlement" where("Leave Type" = const('OL')));
        // }
        // field(11; "Al Balance"; Integer)
        // {
        //    DataClassification = ToBeClassified;            
        // }
        // field(12;"OL Balance"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
    
    keys
    {
        key(PK; Employee)
        {
            Clustered = true;
        }
    } 
    // local procedure CalculateALBalance(): Integer
    // var
    //     LeaveTypeRec: Record "Leave Type";
    //     LeaveEntryRec: Record "Leave Request Entry";
    //     TotalLeave: Integer;
    //     UsedLeave: Integer;
    // begin
    //     LeaveTypeRec.SetRange(Code,'AL');
    //     if LeaveTypeRec.FindFirst() then 
    //         TotalLeave := LeaveTypeRec."Number of Days";
        
    //     LeaveEntryRec.SetRange("Leave Type",'AL');
    //     LeaveEntryRec.SetRange(Employee,Rec.Employee);
    //     LeaveEntryRec.SetRange(Status, LeaveEntryRec.Status::Approved);
    //     if LeaveEntryRec.FindSet() then
    //         repeat
    //             UsedLeave += LeaveEntryRec."No. of Days";
    //         until LeaveEntryRec.Next() = 0;
        
    //     exit(TotalLeave - UsedLeave);
            
    // end;
    // local procedure CalculateOLBalance(): Integer
    // var
    //     LeaveTypeRec: Record "Leave Type";
    //     LeaveEntryRec: Record "Leave Entry";
    //     TotalLeave: Integer;
    //     UsedLeave: Integer;
    // begin
    //     LeaveTypeRec.SetRange(Code,'OL');
    //     if LeaveTypeRec.FindFirst() then
    //         TotalLeave := LeaveTypeRec."Number of Days";
        
    //     LeaveEntryRec.SetRange("Leave Type",'OL');
    //     LeaveEntryRec.SetRange(Employee,Employee);
    //     LeaveEntryRec.SetRange(Status, LeaveEntryRec.Status::Approved);
    //     if LeaveEntryRec.FindSet() then
    //         repeat
    //             UsedLeave += LeaveEntryRec."No. of Days";
    //         until LeaveEntryRec.Next() = 0;
        
    //     exit(TotalLeave - UsedLeave);

    // end;
    // trigger OnModify()
    // begin
    //     "Al Balance" := CalculateALBalance();
    //     "OL Balance" := CalculateOLBalance();
    // end;
}