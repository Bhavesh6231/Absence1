codeunit 60100 "Notification Mgmt"
{
    trigger OnRun()
    begin
    end;
    procedure SendNotification(EmployeeCode: Code[20]; EmployeeName: Text[100]; StartDate: Date; NoOfDays: Integer)
    var
        Notification: Notification;
    begin
        Notification.Message := StrSubstNo('You have been selected as stand-in for %1(%2), who is on leave on %3 for %4 days',
            EmployeeCode,
            EmployeeName,
            StartDate,
            NoOfDays);

        Notification.Send()
    end;
}