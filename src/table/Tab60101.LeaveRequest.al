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
            trigger OnValidate()
            begin
                SetPeriod(Rec."Start Date");
                if (Rec."Start Date" <> 0D) then begin
                    if(Rec."End Date"<> 0D) then 
                        Rec."No. of Days" := CalculateNoofDays(Rec."Start Date",Rec."End Date");

                    if(rec."No. of Days" <> 0) then
                        Rec."End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
                end;
            end;
           
        }
        field(6; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:1;
            MinValue = 0.5;

            trigger OnValidate()
            var
                LeaveBal : Record "Leave Type";
            begin
                if ("No. of Days" MOD 0.5) <> 0 then
                    Error(' No. of days must be entered in muntiple of 0.5');
                
                if ("Start Date" <> 0D) and ("No. of Days" > 0) then
                    "End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
                
                if ("No. of Days" < LeaveBal.Balance) then
                    Error('The Number of leave days requested can not be more than your current Balance.');
            end;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ("End Date" < "Start Date") then
                    Error('End Date can not be less than %1', "Start Date");

                if ("End Date" <> 0D) and ("Start Date" <> 0D) then
                    "No. of Days" := CalculateNoofDays(Rec."Start Date",Rec."End Date");
            end;
        }
        field(8; Comments; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Stand-in"; Code[20])              
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            begin
                if "Stand-in" = Rec.Employee then
                    Error('You cannot select stand in to yourself');

            end;
        }
        field(10; "Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; Employee)
        {
            Clustered = true;
        }
    }
    procedure CalculateEndDate(StartDate: Date; NumberOfDays: Decimal): Date
    var
        CurrentDate : Date;
        WorkingDays : Decimal;
    begin
        if NumberOfDays <= 0 then
            exit(StartDate);
        WorkingDays := 0;
        CurrentDate := StartDate;
        repeat
            if IsWorkingDay(CurrentDate) then
                WorkingDays += 1;

            if WorkingDays < NumberofDays then
                CurrentDate := CurrentDate + 1;
        Until WorkingDays >= NumberofDays;
        exit(CurrentDate);
    end;

    procedure CalculateNoofDays(StartDate: Date;EndDate: Date):Integer
    var
        CurrentDate : Date;
        WorkingDays : Decimal;
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            exit(0);
        WorkingDays := 0;
        CurrentDate := StartDate;
        repeat
            if IsWorkingDay(CurrentDate) then
                WorkingDays += 1;
         
            CurrentDate := CurrentDate + 1;
        until CurrentDate > EndDate;
        exit(WorkingDays);
    end; 

    procedure IsWorkingDay(checkDate: Date):Boolean
    var
        TimesheetRecRef : RecordRef;
        FieldRefStatus : FieldRef;
        FieldRefDate : FieldRef;
        IsWorkingDay: Boolean;
    begin
        TimesheetRecRef.Open(80007);
        FieldRefDate := TimesheetRecRef.Field(2); // Field 2 - Date 
        FieldRefDate.SetRange(checkDate);
        FieldRefStatus := TimesheetRecRef.Field(90); // Field 90 - Status
        FieldRefStatus.SetFilter('%1|%2', 30, 40);  // Status Enum Values - 30 Weekly Off, 40 Public Holiday
        IsWorkingDay := TimesheetRecRef.IsEmpty();
        exit(IsWorkingDay);
    end;
    
    procedure SetPeriod(DT:Date)
    begin
        if DT = 0D then
            DT := Today;
            
        Rec.Period := Rec.GetLeavePeriod(DT);
    end;
    procedure GetLeavePeriod(DT: Date): Code[20]
    var
        LeavePeriodRec : Record "Leave Period";
    begin
        LeavePeriodRec.SetRange("Start Date", 0D, DT);
        if LeavePeriodRec.FindLast() then;
        exit(LeavePeriodRec.Code);
    end;
}