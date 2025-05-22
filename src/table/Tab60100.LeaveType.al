table 60100 "Leave Type"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Leave Type";
    DrillDownPageID = "Leave Type";
    
    fields
    {
        field(1;Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Number of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(4; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(5;"Approved Leaves"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Leave Entry"."No. of Days" where("Leave Type" = field(Code),Employee = field("Employee Filter"),Status = const(Approved),"Start Date" = field("Date Filter"),"End Date" = field("Date Filter")));
        }
        field(6; "Max Carry Forward";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Description;Text[150])
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