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
    
}