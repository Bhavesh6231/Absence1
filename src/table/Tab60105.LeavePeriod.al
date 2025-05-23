table 60105 "Leave Period"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}