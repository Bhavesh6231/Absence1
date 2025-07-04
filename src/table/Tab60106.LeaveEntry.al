    table 60106 "Leave Entry"
    {
        DataClassification = ToBeClassified;
        LookupPageId = "Leave Entry";
        DrillDownPageId = "Leave Entry";
        
        fields
        {
            field(1;"Entry No."; Integer)
            {
                DataClassification = ToBeClassified;
                AutoIncrement = true;
                Editable = false;
            }
            field(2; "Leave Request Entry No."; Integer)
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
            field(8; "No. of Days"; Decimal)
            {
                DataClassification = ToBeClassified;
                DecimalPlaces = 0:1;
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
}