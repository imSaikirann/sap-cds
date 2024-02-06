using { com.saikiran.studentPer as db } from '../db/schema';

service StudentP {

    entity Student as projection on db.Student;
    entity Subjects as projection on db.Subjects{
        @UI.Hidden
        ID,
        *
    };
    entity Courses as projection on db.Courses{
           @UI.Hidden
        ID,
        *
    }
      entity Books as projection on db.Books{
           @UI.Hidden
        ID,
        *
    }


}
//For Create button
annotate StudentP.Student with @odata.draft.enabled;
annotate StudentP.Subjects with @odata.draft.enabled ;
annotate StudentP.Courses with  @odata.draft.enabled;
annotate StudentP.Books with @odata.draft.enabled;




//Student Table annotate
annotate StudentP.Student with @(
    UI.LineItem:[
        {
            $Type:'UI.DataField',
            Value:student_id
        },
          {
            $Type:'UI.DataField',
            Value:name
        },
          {
            $Type:'UI.DataField',
            Value:grade
        },
          {
            $Type:'UI.DataField',
            Value:per
        },
          {
            $Type : 'UI.DataField',
            Label : 'Course Selected',
            Value : course.code
        },
        {
            $Type : 'UI.DataField',
            Label : 'Subjects Enrolled',
            Value : Subjects.sub.description,
        },
        
        
        
    ],
    UI.SelectionFields:[student_id,name,grade,per,],
    UI.FieldGroup #StudentInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
             {
            $Type:'UI.DataField',
            Value:student_id,
        },
        {
            $Type:'UI.DataField',
            Value:name,
        },
          {
            $Type:'UI.DataField',
            Value:grade,
        },
           {
                $Type: 'UI.DataField',
                Value: course_ID,
            },
          {
            $Type:'UI.DataField',
            Value:per,
        },
         
         

        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentI',
            Label:'Student Information',
            Target: '@UI.FieldGroup#StudentInformation',
        },
         {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentSubjectsFacet',
            Label : 'Student Subjects Information',
            Target : 'Subjects/@UI.LineItem',
        },
    ],

) ;


// annotation for Student table with selcted subjects  
annotate StudentP.Student.Subjects with @(
 UI.LineItem: [
        {
            Label: 'Subjects',
            Value :  sub_ID
        },
 ],
 UI.FieldGroup #SelectedSubjects : {
    $Type : 'UI.FieldGroupType',
    Data : [
        {
            Value : sub_ID
        }
    ],
 },
 UI.Facets : [
    {
        $Type :'UI.ReferenceFacet',
        ID : 'SubjectsFacet',
        Label : 'Subjects',
        Target : '@UI.FieldGroup#SelectedSubjects',
    },
 ],
);

//annoation for subjects
annotate StudentP.Subjects with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Subjects : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'SubjectsFacet',
            Label : 'Subjects',
            Target : '@UI.FieldGroup#Subjects',
        },
    ],

);

//annotation for course table
annotate StudentP.Courses with @(
    UI.LineItem: [
        {
            Value : code
        },
        {
            Value : description
        },
       {
            Label : 'Course Books ',
            Value : Books.book.description
        },
    ],
     UI.FieldGroup #CourseInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#CourseInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CourseBookFacet',
            Label : 'Course Books',
            Target : 'Books/@UI.LineItem',
        },
        
    ],
    
);

//annaoation for books 
annotate StudentP.Books with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
    UI.FieldGroup #Books :{
        $Type : 'UI.FieldGroupType',
        Data :[
            {
                Value : code,
            },
            {
                Value : description
            }
        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#Books'
        }
    ]
);

//anaoation for Couses for books
annotate StudentP.Courses.Books with @(
 UI.LineItem: [
        {
            Label: 'Books',
            Value : book_ID
        },
 ],
 UI.FieldGroup #CourseBooks : {
    $Type : 'UI.FieldGroupType',
    Data : [
        {
            Value :book_ID
        }
    ],
 },
 UI.Facets : [
    {
        $Type :'UI.ReferenceFacet',
        ID : 'CourseBooksFacet',
        Label : 'CourseBooks',
        Target : '@UI.FieldGroup#CourseBooks',
    },
 ],
);

//linking
annotate StudentP.Student.Subjects with {
    sub @(
        Common.Text: sub.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Subjects',
            CollectionPath : 'Subjects',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty :  sub_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

//for getting dropdown
annotate StudentP.Student with {
    course @(
        Common.Text: course.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Courses',
            CollectionPath : 'Courses',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : course_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );
}

annotate StudentP.Courses.Books with {
    book @(
        Common.Text: book.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Books',
            CollectionPath : 'Books',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : book_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
};
