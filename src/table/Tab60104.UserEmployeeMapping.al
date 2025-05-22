table 60104 "User Employee Mapping"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"User Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(2; "Employee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
    }
    
    keys
    {
        key(PK; "User Id")
        {
            Clustered = true;
        }
    }
}