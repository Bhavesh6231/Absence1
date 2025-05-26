table 60103 "Leave Request Entry"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No.";Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false; 
            AutoIncrement = true;
        }
        field(2; Employee; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if EmployeeRec.Get(Employee) then begin
                    "Employee Name" := EmployeeRec.FullName();
                end
                else
                    "Employee Name" := '';

            end;
        }
        field(3;"Employee Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            
        }
        field(5; "Request Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Leave Type"; Code[20])                
        {
            TableRelation = "Leave Type";
            DataClassification = ToBeClassified;
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
            end;
        }
        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:1;
            MinValue = 0.5;

            trigger OnValidate()
            begin
                if ("No. of Days" MOD 0.5) <> 0 then
                    Error(' No. of days must be entered in muntiple of 0.5');

                "End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
            end;
        }
        field(10; Comments; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Enum "Leave Status")         
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Approved By"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Stand-in"; Code[20])                 
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    begin
        if "Request Date" = 0D then begin
            "Request Date" := Today;
        end;
        if "Request Time" = 0T then begin
            "Request Time" := Time;
        end;
    end;
    procedure CalculateEndDate(StartDate: Date; NumberOfDays: Decimal): Date
    var
        Calendar : Record "Customized Calendar Change";
        CurrentDate : Date;
        WorkingDays : Decimal;
    begin
        if NumberOfDays <= 0 then
            exit(StartDate);

        WorkingDays := 0;
        CurrentDate := StartDate;

        repeat
            Calendar.Reset();
            Calendar.SetRange(Date, CurrentDate);
            Calendar.SetRange(Nonworking,true);

            if not Calendar.FindFirst() then
                WorkingDays += 1;

            if WorkingDays < NumberofDays then
                CurrentDate := CurrentDate + 1;

        Until WorkingDays >= NumberofDays;

        exit(CurrentDate);
    end;
}