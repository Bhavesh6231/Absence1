permissionset 60100 Absence
{
    Assignable = true;
    
    Permissions = 
        tabledata "Leave Type" = RMID,
        tabledata "Leave Request" = RMID,
        tabledata "Leave Entitlement" = RMID,
        tabledata "Leave Entry" = RMID,
        tabledata "User Employee Mapping" = RMID,

        table "Leave Type" = X,
        table "Leave Request" = X,
        table "Leave Entitlement" = X,
        table "Leave Entry" = X,
        table "User Employee Mapping" = X,

        page "Leave Type" = X,
        page "Leave Request" = X,
        page "Leave Entitlement" = X,
        page "Leave Entry" = X,
        page "User Employee Mapping" = X;
}