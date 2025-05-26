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

            trigger OnValidate()
            begin
                if ("No. of Days" MOD 0.5) <> 0 then
                    Error(' No. of days must be entered in muntiple of 0.5');
            end;
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
    }
    
    keys
    {
        key(PK; Employee)
        {
            Clustered = true;
        }
    } 
}