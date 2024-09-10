
namespace todo.app;

using {todo.common} from './commons';
using { managed, Country } from '@sap/cds/common';

context transaction {
entity Todos {
        key ID        : Integer;
        Title        : String(100);
        Description  : String(500);
        Status       : String(20);
        // e.g., "Initialized", "Pending", "Completed"
        DueDate      : Date;
        employee      : Association to master.employee;
}

entity Status{
        key code : String enum {
        Completed   = 'Completed';
        Pending = 'Pending';
        InProgress    = 'InProgress';
        Initialized   = 'Initialized';
        };
        description : String(12);
}
}
context master {
entity employee : managed {
    Key EMPID         : Integer;
    firstname  : String;
    lastname   : String;
    email      : common.Email;
    gender     : common.gender;
    contact    : common.PhoneNumber;
    addresses : Association to master.addresses;
    department : Association to master.department;

}

entity addresses{
    key ID      : Integer;
    hno         : String;
    street      : String;
    city        : String;
    country : Country;
  }

  entity department {
    Key code : String;
    name : String;
  }
}