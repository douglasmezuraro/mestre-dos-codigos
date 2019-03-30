unit Model.Person;

interface

uses
  Model.Gender;

type
  TPerson = class
  private
    FName: string;
    FLastName: string;
    FPhone: string;
    FBirth: TDate;
    FGender: TGender;
    FCPF: string;
    FEmail: string;
  public
    property Name: string read FName write FName;
    property LastName: string read FLastName write FLastName;
    property Birth: TDate read FBirth write FBirth;
    property Phone: string read FPhone write FPhone;
    property Gender: TGender read FGender write FGender;
    property CPF: string read FCPF write FCPF;
    property Email: string read FEmail write FEmail;
  end;

implementation

end.

