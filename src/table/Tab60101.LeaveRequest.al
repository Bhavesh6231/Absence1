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
        field(8; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Comments; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Stand-in"; Code[20])                
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
    
    keys
    {
        key(PK; Employee)
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