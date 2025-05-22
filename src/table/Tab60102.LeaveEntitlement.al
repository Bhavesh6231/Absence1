table 60102 "Leave Entitlement"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Employee; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            begin
                Rec.CalcFields("Employee Name");
            end;
        }
        field(3;"Employee Name";Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No." = field(Employee)));
        }
        field(4; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Type";
            DataClassification = ToBeClassified;
        }
        field(5; Quota; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Carried Forward"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; Year,Employee,"Leave Type")
        {
            Clustered = true;
        }
    }
}