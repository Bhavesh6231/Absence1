page 60104 "User Employee Mapping"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Employee Mapping";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User Id"; Rec."User Id")
                {
                    LookupPageId = "User Lookup";
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field(Employee; Rec.Employee)
                {
                    ToolTip = 'Specifies the value of the Employee field.', Comment = '%';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}