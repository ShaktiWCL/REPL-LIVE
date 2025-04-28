report 50017 "Attendance Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/AttendanceDetails.rdl';

    dataset
    {
        dataitem("Time Sheet Detail"; "Time Sheet Detail")
        {
            RequestFilterFields = "Resource No.";
            column(Date_TimeSheetDetail; "Time Sheet Detail".Date)
            {
            }
            column(EmployeeCode_TimeSheetDetail; "Time Sheet Detail"."Resource No.")
            {
            }
            column(ProjectCode_TimeSheetDetail; "Time Sheet Detail"."Job No.")
            {
            }
            column(Usage_TimeSheetDetail; "Time Sheet Detail".Quantity)
            {
            }
            column(Status_TimeSheetDetail; "Time Sheet Detail".Status)
            {
            }
            column(ExtraUsage_TimeSheetDetail; "Time Sheet Detail"."Extra Hours")
            {
            }
            column(EmployeeName_TimeSheetDetail; "Time Sheet Detail"."Employee Name")
            {
            }
            column(ManagerNo; ManagerNo)
            {
            }
            column(ManagerName; ManagerName)
            {
            }
            column(TotalHours; TotalHours)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Employee.GET("Resource No.") THEN
                    IF Employee1.GET(Employee."Manager No.") THEN BEGIN
                        ManagerNo := Employee."Manager No.";
                        ManagerName := Employee1."First Name";
                    END ELSE BEGIN
                        ManagerNo := '';
                        ManagerName := '';
                    END;

                IF ("Time Sheet Detail".Day = 'Sunday') AND (Quantity = 0) THEN
                    TotalHours := 'Sunday'
                ELSE
                    TotalHours := FORMAT("Time Sheet Detail".Quantity);
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Date, StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {

                    trigger OnValidate()
                    begin
                        EndDate := CALCDATE('CM', StartDate);
                    end;
                }
                field("End Date"; EndDate)
                {
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            StartDate := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
            EndDate := CALCDATE('CM', StartDate);
        end;
    }

    labels
    {
    }

    var
        Employee: Record Employee;
        Employee1: Record Employee;
        ManagerNo: Code[20];
        ManagerName: Text;
        StartDate: Date;
        EndDate: Date;
        TotalHours: Text;
}

