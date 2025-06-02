page 60103 "Leave Request Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Request Entry";
    Editable = false;
    SourceTableView = sorting("Entry No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Employee;Rec.Employee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the Employee';
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Request Date";Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Request Time";Rec."Request Time")
                {
                    ApplicationArea = All;
                }
                field("Leave Type";Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date";Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date";Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Days";Rec."No. of Days")
                {
                    ApplicationArea = All;
                }
                field(Comments;Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approved By";Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Stand-in";Rec."Stand-in")
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
            action("Leave Entry")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    LeaveEntryRec: Record "Leave Entry";
                begin
                    LeaveEntryRec.SetRange("Leave Request Entry No.",Rec."Entry No.");
                    Page.RunModal(Page:: "Leave Entry", LeaveEntryRec);
                end;
            }
             action("Leave Request Log")
            {
                ApplicationArea = All;
                Caption = 'Leave Request Log';
                Promoted = true;
                PromotedCategory = Process;
                Image = List;
                trigger OnAction()
                var 
                    LeaveReqLog: Record "Leave Request Log";
                begin
                    LeaveReqLog.SetRange("Leave Request Entry No.",Rec."Entry No.");
                    Page.Run(Page:: "Leave Request Log");
                end;
                
            }
        }
    }
}