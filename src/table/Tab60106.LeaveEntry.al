    table 60106 "Leave Entry"
    {
        DataClassification = ToBeClassified;
        
        fields
        {
            field(1;"Entry No."; Code[20])
            {
                DataClassification = ToBeClassified;
            }
            field(2; "Leave Request Entry No."; Code[20])
            {
                DataClassification = ToBeClassified;
                TableRelation = "Leave Request Entry";
            }
            field(3; Employee; Code[20])
            {
                DataClassification = ToBeClassified;
                TableRelation = Employee;
            }
            field(4; Period; Code[20])
            {
                DataClassification = ToBeClassified;
                TableRelation = "Leave Period";
            }
            field(5; Type; Enum Type)
            {
                DataClassification = ToBeClassified;
            }
            field(6; "Start Date"; Date)
            {
                DataClassification = ToBeClassified;
            }
            field(7; "End Date"; Date)
            {
                DataClassification = ToBeClassified;
            }
            field(8; "No. of Days"; Integer)
            {
                DataClassification = ToBeClassified;
            }
            field(9; "Leave Type"; Code[20])
            {
                DataClassification = ToBeClassified;
                TableRelation = "Leave Type";
            }
            field(10; Status; Enum "Leave Status")
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