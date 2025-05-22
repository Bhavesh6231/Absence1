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
        field(6; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
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
        field(9; "Leave Entitlement Al"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = sum 
        }  
        field(10; "Leave Entitlement OL"; Integer)
        {
            FieldClass = FlowField;
        }
        field(11; "Al Balance"; Integer)
        {
            FieldClass = FlowField;
        
        }
        field(12;"OL Balance"; Integer)
        {
            FieldClass = FlowField;
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