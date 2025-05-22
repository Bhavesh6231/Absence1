pageextension 60100 Employees extends "Employee List"
{
    actions
    {
        addafter(Contact)
        {
            action("Leave Entry")
            {
                Caption = ' Leave Entry';
                ApplicationArea = All;
                Image = View;
                trigger OnAction()
                begin
                    Page.Run(Page::"Leave Entry");
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}