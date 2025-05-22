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
                trigger OnAction()
                begin
                    Page.Run(Page::"Leave Entitlement");
                end;
            }
        }
    }
}