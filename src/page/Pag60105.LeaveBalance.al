page 60105 "Leave Balance"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Leave Type";
    DataCaptionFields = "Period Filter";

    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                
                ShowCaption = false;
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Carried Forward"; Rec."Carried Forward")
                {
                    ToolTip = 'Specifies the value of the Carried Forward field.', Comment = '%';
                }
                field("Entitlement"; Rec."Entitlement")
                {
                    ToolTip = 'Specifies the value of the Entitlement field.', Comment = '%';
                }
                field("Approved Leaves"; Rec."Approved Leaves")
                {
                    ToolTip = 'Specifies the value of the Approved Leaves field.', Comment = '%';
                }
                field("Leave Requested"; Rec."Leave Requested")
                {
                    ToolTip = 'Specifies the value of the Leave Requested field.', Comment = '%';
                }
                field("Leave Rejected"; Rec."Leave Rejected")
                {
                    ToolTip = 'Specifies the value of the Leave Rejected field.', Comment = '%';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                }
            }
        }
    }
}