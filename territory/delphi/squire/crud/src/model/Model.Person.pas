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
    FGender: TGender;
    FCPF: string;
    FEmail: string;
    FDate: TDate;
    FRG: Integer;
  public
    property Name: string read FName write FName;
    property LastName: string read FLastName write FLastName;
    property Phone: string read FPhone write FPhone;
    property Gender: TGender read FGender write FGender;
    property CPF: string read FCPF write FCPF;
    property Email: string read FEmail write FEmail;
    property Birth: TDate read FDate write FDate;
    property RG: Integer read FRG write FRG;
  end;

implementation

end.

