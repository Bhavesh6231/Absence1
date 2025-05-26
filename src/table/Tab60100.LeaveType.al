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
        field(4; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(5; "Max Carry Forward";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;Description;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Carried Forward"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0:1;
            CalcFormula = sum("Leave Entry"."No. of Days" where("Leave Type" = field(code),Employee = field("Employee Filter"),Type = const("Carried Forward"),"Start Date" = field("Period Filter"), "End Date" = field("Period Filter")));
        }
        field(8; Entitlement; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0:1;
            CalcFormula = sum("Leave Entry"."No. of Days" where("Leave Type" = field(Code),Employee = field("Employee Filter"), Type = const(Entitlement), "Start Date" = field("Period Filter"), "End Date" = field("Period Filter")));
        }
        field(9; "Approved Leaves"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0:1;
            CalcFormula = - sum("Leave Entry"."No. of Days" where("Leave Type" = field(Code),Employee = field("Employee Filter"),Status = const(Approved),"Start Date" = field("Period Filter"),"End Date" = field("Period Filter")));
        }
        field(10; "Leave Requested"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0:1;
            CalcFormula = - sum("Leave Request Entry"."No. of Days" where(Employee = field("Employee Filter"),"Leave Type" = field(Code)));
        }
        field(11; "Balance"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0:1;
            CalcFormula = sum("Leave Entry"."No. of Days" where(Employee = field("Employee Filter"),"Leave Type" = field(Code),"Start Date" = field("Period Filter"),"End Date" = field("Period Filter")));
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