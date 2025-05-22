page 60102 "Leave Entitlement"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Entitlement";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Employee;Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field("Leave Type";Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field(Quota;Rec.Quota)
                {
                    ApplicationArea = All;
                }
                field("Carried Forward";Rec."Carried Forward")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}