unit Email.Exceptions;

interface

uses
  System.SysUtils;

type
  EEmailSenderArgumentException = class abstract(EArgumentException);
  EEmailEmptyHost = class sealed(EEmailSenderArgumentException);
  EEmailEmptyUsername = class sealed(EEmailSenderArgumentException);
  EEmailEmptyAddress = class sealed(EEmailSenderArgumentException);
  EEmailEmptyPassword = class sealed(EEmailSenderArgumentException);
  EEmailEmptyBody = class sealed(EEmailSenderArgumentException);
  EEmailEmptySubject = class sealed(EEmailSenderArgumentException);
  EEmailEmptyRecipients = class sealed(EEmailSenderArgumentException);

implementation

end.

