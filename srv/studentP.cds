using { com.saikiran.Student as db  } from '../db/schema';

//projections
service StudentService {
    entity Student as projection on db.Student;

}

//creat button
annotate StudentService.Student with @odata.draft.enabled;


//annotation for Student Table

annotate StudentService.Student with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value: s_id
        },
         {
            $Type : 'UI.DataField',
            Value: fname
        },
         {
            $Type : 'UI.DataField',
            Value: lname
        },
    ],
    UI.FieldGroup #StudentInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value: s_id,
        },
         {
            $Type : 'UI.DataField',
            Value: fname,
        },
         {
            $Type : 'UI.DataField',
            Value: lname,
        },
        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Student',
            Label: 'Student Information',
            Target: '@UI.FieldGroup#StudentInformation',
        }
    ]
      
) ;


