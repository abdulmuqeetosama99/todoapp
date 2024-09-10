using { todo.app.master, todo.app.transaction  } from '../db/schema';

service TodoappService {
    @readonly entity GetTodos as projection on transaction.Todos;
    @readonly entity GetTitles as select from transaction.Todos{ID,Title};
    @readonly entity GetStatus as select from transaction.Status{code,description};
    @insertonly entity CreateTodos as projection on transaction.Todos;
    @updateonly entity UpdateTodos as projection on transaction.Todos;
    @deleteonly entity DeleteTodos as projection on transaction.Todos;
    @readonly entity EmployeeSet as projection on master.employee{
        EMPID,
        firstname,
        lastname,
        email,
        gender,
        contact,
        department.name as departmentName,
        addresses.ID as addresses
    };
    @readonly entity DepartmentSet as projection on master.department;
    @readonly entity AddressSet as projection on master.addresses;

    // action  CreateTodos(ID : UUID, Title        : String(100),
    //     Description  : String(500),
    //     Status       : String(20),
    //     DueDate      : Date) returns String;
    // @readonly entity GetTodos as projection on transaction.Todos;
    // entity Todos as projection on transaction.Todos;
    // entity Todos_get as projection on transaction.Todos;
}
