namespace todo.common;
type gender : String(1) enum{
    male = 'M';
    female = 'F';
    undisclosed = 'U';
};

type PhoneNumber: String(30)@assert.format : '/^\d{3}-\d{3}-\d{4}$/';
type Email: String(255); 