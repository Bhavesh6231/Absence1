page 60103 "Leave Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Leave Entry";
    
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
                    trigger OnValidate()
                    begin
                        Rec."End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
                    end;
                }
                field("End Date";Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Days";Rec."No. of Days")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec."End Date" := CalculateEndDate(Rec."Start Date",Rec."No. of Days");
                    end;
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
    local procedure CalculateEndDate(StartDate: Date; NumberOfDays: Integer): Date
    var
        Calendar : Record "Customized Calendar Change";
        CurrentDate : Date;
        WorkingDays : Integer;
    begin
        if NumberOfDays <= 0 then
            exit(StartDate);

        WorkingDays := 0;
        CurrentDate := StartDate;

        repeat
            Calendar.Reset();
            Calendar.SetRange(Date, CurrentDate);
            Calendar.SetRange(Nonworking,true);

            if not Calendar.FindFirst() then
                WorkingDays += 1;

            if WorkingDays < NumberofDays then
                CurrentDate := CurrentDate + 1;

        Until WorkingDays >= NumberofDays;

        exit(CurrentDate);
    end;

}