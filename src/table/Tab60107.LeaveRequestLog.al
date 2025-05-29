table 60107 "Leave Request Log"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Leave Request Log";
    LookupPageId = "Leave Request Log";
    
    fields
    {
        field(1;"Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Leave Request Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Request Entry";
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Comment; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; User; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(6; Time; Time)
        {
            DataClassification = ToBeClassified;
        }

    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}