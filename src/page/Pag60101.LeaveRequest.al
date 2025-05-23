page 60101 "Leave Request"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Request";
    SourceTableTemporary = true;
    
    layout
    {
        area(Content)
        {
            group("Request")
            {
                ShowCaption = false;
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Type field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Days field.', Comment = '%';
                }
                 field("Stand-in"; Rec."Stand-in")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stand-in field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                    MultiLine = true;
                }
                // field("Leave Entitlement Al"; Rec."Leave Entitlement Al")
                // {
                //     ToolTip = 'Specifies the value of the Leave Entitlement Al field.', Comment = '%';
                // }
                // field("Leave Entitlement OL"; Rec."Leave Entitlement OL")
                // {
                //     ToolTip = 'Specifies the value of the Leave Entitlement OL field.', Comment = '%';
                // }
                // field("Al Balance"; Rec."Al Balance")
                // {
                //     ToolTip = 'Specifies the value of the Al Balance field.', Comment = '%';
                // }
                // field("OL Balance"; Rec."OL Balance")
                // {
                //     ToolTip = 'Specifies the value of the OL Balance field.', Comment = '%';
                // }
                
            }
            part("Leave Balance"; "Leave Balance")
            {
                Editable = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Caption = 'Submit';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    LeaveManagement : Codeunit "Leave Management";
                begin
                    LeaveManagement.SubmitLeaveRequest(Rec);
                end;
            }
            action("Leave Entry")
            {
                ApplicationArea = All;
                Caption = 'Leave Entry';
                Promoted = true;
                PromotedCategory = Process;
                Image = List;
                RunObject = page "Leave Request Entry";
                RunPageLink = Employee = field(Employee);
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Employee Name");
    end;
    trigger OnOpenPage()
    begin
        if UserMap.Get(UserId()) then begin
            Rec.Init();
            Rec.Employee := UserMap.Employee;
            Rec.Insert();
            Rec.SetRange(Employee,UserMap.Employee);
            rec.CalcFields("Employee Name");
        end else
            Error('User is not mapped with Employee. You cannot place a leave request.');
        
    end;

    var
        UserMap : Record "User Employee Mapping";

}