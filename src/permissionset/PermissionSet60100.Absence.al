permissionset 60100 Absence
{
    Assignable = true;
    
    Permissions = 
        tabledata "Leave Type" = RMID,
        tabledata "Leave Request" = RMID,
        tabledata "Leave Request Entry" = RMID,
        tabledata "User Employee Mapping" = RMID,
        tabledata "Leave Period" = RMID,
        tabledata "Leave Entry" = RMID,
        tabledata "Leave Request Log" = RMID,

        table "Leave Type" = X,
        table "Leave Request" = X,
        table "Leave Request Entry" = X,
        table "User Employee Mapping" = X,
        table "Leave Period" = X,
        table "Leave Entry" = X,
        table "Leave Request Log" = X,

        page "Leave Type" = X,
        page "Leave Request" = X,
        page "Leave Balance" = X,
        page "Leave Request Entry" = X,
        page "User Employee Mapping" = X,
        page "Leave Entry" = X,
        page "Leave Period" = X;
        }