unit Email.Exceptions;

interface

uses
  System.SysUtils;

type
  EEmailSenderArgumentException = class abstract(EArgumentException);
  EEmailHostCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailUserNameCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailAddressCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailPasswordCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailBodyCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailSubjectCannotBeEmpty = class sealed(EEmailSenderArgumentException);
  EEmailRecipientsCannotBeEmpty = class sealed(EEmailSenderArgumentException);

implementation

end.

