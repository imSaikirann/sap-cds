namespace com.saikiran.studentPer;
using {cuid,managed  } from '@sap/cds/common';

@assert.unique:{
    student_id  :[ student_id ]
}


entity Student : cuid,managed {
    @title : 'Student ID'
     student_id : String(10);

     @title : 'Student Name'
    name : String(10);

     @title : 'Grade'
    grade : String(10);

    @title : 'Percentage'
     per: String(10);

   
    Subjects : Composition of many{
        key ID : UUID;
        sub : Association to Subjects;
    }
 

}



entity Subjects : cuid ,managed{
    @title:'Code'
    code:String(3);
    @title:'Description'
    description:String(20);
    
}

