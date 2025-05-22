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
    trigger OnOpenPage()
    begin
        if UserMap.Get(UserId()) then begin
            Rec.Employee := UserMap.Employee;
            Rec.Init();
            Rec.Insert();
            Rec.SetRange(Employee,UserMap.Employee);
            rec.CalcFields("Employee Name");
        end else
            Error('User is not mapped with Employee. You cannot place a leave request.');
    end;

    var
        UserMap : Record "User Employee Mapping";
}