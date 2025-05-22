page 60100 "Leave Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Type";
    
    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Number of Days";Rec."Number of Days")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Leave Entitlement")
            {
                Caption = 'Leave Entitlement';
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                // trigger OnAction()
                // var
                //     LeaveEntRec: Record "Leave Entitlement";
                //     UserMappingRec: Record "User Employee Mapping";
                // begin
                //     if UserMappingRec.Get(UserId) then begin
                //         LeaveEntRec.SetRange(Employee, UserMappingRec.Employee);
                        
                //         Page.Run(Page::"Leave Entitlement",LeaveEntRec);
                //     end else
                //         Error('You are not mapped to any employee.');
                // end;
                trigger OnAction()
                begin
                    Page.Run(Page::"Leave Entitlement");
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        LeaveEntRec: Record "Leave Entitlement";
    begin
        LeaveEntRec.SetRange("Leave Type",Rec.Code);
        if LeaveEntRec.FindFirst() then 
            Error('You Cannot delete Leave Type because it is used in Leave Entitlement.');
        exit(true);
    end;
}