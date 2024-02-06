namespace com.saikiran.Student;
using { cuid,managed } from '@sap/cds/common';


entity Student : cuid,managed {
    @title : 'Student ID'
    s_id : String(10);
    @title : 'Student First Name'
    fname : String(10) @mandatory;
    @title : 'Student Last Name'
    lname : String(20) @mandatory;
}

