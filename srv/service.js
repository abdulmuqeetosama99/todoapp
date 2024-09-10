const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { Todos } = this.entities('todo.app.transaction');
    const { Status } = this.entities('todo.app.transaction');
    const { EmployeeSet } = this.entities('todo.app.master');
    const { DepartmentSet } = this.entities('todo.app.master');

  this.on('READ', 'GetTodos', async (req) => {
    const ID = req.params[0];

    if (ID) {
      const todo = await SELECT.from(Todos).where({ ID });
      if (todo.length === 0) {
        return req.error(404, `Todo List with ID ${ID} not found.`);
      }
      return todo;
    }

    return await SELECT.from(Todos);
  });

  this.on('CREATE', 'CreateTodos', async (req) => {
    const { Title, Description, Status, DueDate } = req.data;
    const ID = await getNextId();

    const dataInsert = {
      ID,
      Title,
      Description,
      Status,
      DueDate,
    };

    await INSERT.into(Todos).entries(dataInsert);
    return dataInsert;
  });

  this.on('UPDATE', 'UpdateTodos', async (req) => {
    const { ID, Title, Description, Status, DueDate } = req.data;

    await UPDATE(Todos).set({
      Title,
      Description,
      Status,
      DueDate,
    }).where({ ID });

    return { ID }; // Return the updated ID for confirmation
  });

  this.on('DELETE', 'DeleteTodos', async (req) => {
    const ID = req.params[0];

    await DELETE.from(Todos).where({ ID });
    return { ID }; // Return the deleted ID for confirmation
  });

  this.on('READ', 'GetTitles', async (req) => {
    return await SELECT.from(Todos).columns('ID', 'Title');
  });

  this.on('READ', 'GetStatus', async (req) => {
    const code = req.params[0];

    if (code) {
      const status = await SELECT.from(Status).where({ code });
      if (status.length === 0) {
        return req.error(404, `Status List with ID ${code} not found.`);
      }
      return status;
    }

    return await SELECT.from(Status);
  });

  async function getNextId() {
    const results = await SELECT.from(Todos).orderBy('ID desc').limit(1);
    return results.length ? results[0].ID + 1 : 1;
  }
});