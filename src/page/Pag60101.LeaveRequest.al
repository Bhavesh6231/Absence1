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
                trigger OnAction()
                var
                    LeaveEntRec : Record "Leave Entry";
                begin
                    LeaveEntRec.Init();
                    LeaveEntRec."Entry No." := 0;
                    LeaveEntRec.Employee := Rec.Employee;
                    LeaveEntRec."Employee Name" := Rec."Employee Name";
                    LeaveEntRec."Leave Type" := Rec."Leave Type";
                    LeaveEntRec."Start Date" := Rec."Start Date";
                    LeaveEntRec."No. of Days" := Rec."No. of Days";
                    LeaveEntRec."Request Date" := Rec."Request Date";
                    LeaveEntRec."Request Time" := Rec."Request Time";
                    LeaveEntRec.Comments := Rec.Comments;
                    LeaveEntRec."Stand-in" := Rec."Stand-in";
                    LeaveEntRec.Insert();

                    Message('Leave Request submitted successfully.');
                end;
            }
            action("Leave types")
            {
                Caption = 'Leave Type';
                ApplicationArea = All;
                Image = Absence;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    LeaveTypePag : Page "Leave Type";
                begin
                    LeaveTypePag.Editable := false;
                    LeaveTypePag.Run();
                end;
            }
            action("Leave Entitlement")
            {
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Leave Entitlement";
                RunPageLink = Employee = field(Employee);
                Image = List;
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