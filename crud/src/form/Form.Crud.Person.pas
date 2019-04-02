unit Form.Crud.Person;

interface

uses
  Form.Crud,
  Helper.Vcl,
  Model.Gender,
  Model.Person,
  System.Actions,
  System.Classes,
  System.DateUtils,
  System.SysUtils,
  System.Types,
  Util.Messages,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.StdCtrls;

type
  TCrudPerson = class(TCrud)
    LabelName: TLabel;
    EditName: TEdit;
    LabelLastName: TLabel;
    EditLastName: TEdit;
    LabelPhone: TLabel;
    EditPhone: TEdit;
    LabelEmail: TLabel;
    EditEmail: TEdit;
    LabelCPF: TLabel;
    EditCPF: TEdit;
    RadioGroupGender: TRadioGroup;
    LabelBirth: TLabel;
    EditBirth: TDateTimePicker;
    procedure EditNameExit(Sender: TObject);
    procedure EditEmailExit(Sender: TObject);
    procedure EditCPFExit(Sender: TObject);
    procedure EditPhoneExit(Sender: TObject);
    procedure EditLastNameExit(Sender: TObject);
    procedure EditBirthChange(Sender: TObject);
  protected
    procedure Initialize; override;

    procedure ViewToModel; override;
    procedure ModelToView; override;
    function ModelToArray: TArray<string>; override;

    function DefineRequiredControls: TArray<TWinControl>; override;

    function CreateModel: TObject; override;
    function GetModel: TPerson; reintroduce;
  end;

implementation

{$R *.dfm}

{ TCrudPerson }

function TCrudPerson.CreateModel: TObject;
begin
  Result := TPerson.Create;
end;

procedure TCrudPerson.Initialize;
const
  Titles: TArray<string> = ['Nome', 'Sobrenome', 'CPF', 'Telefone', 'E-mail'];
begin
  inherited;
  Grid.AddHeader(Titles);
end;

procedure TCrudPerson.EditBirthChange(Sender: TObject);
var
  Birth: TDateTime;begin  inherited;  Birth := (Sender as TDateTimePicker).Date;  if CompareDateTime(Birth, EndOfTheDay(Today)) = GreaterThanValue then  begin    TMessage.Warning(
      'Data inválida, a data de nascimento "%s" não pode ser maior que a data atual "%s".',
      [DateToStr(Birth), DateToStr(Today)]);
  end;
end;

procedure TCrudPerson.EditCPFExit(Sender: TObject);
const
  Pattern = '\d{3}.\d{3}.\d{3}-\d{2}';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TCrudPerson.EditEmailExit(Sender: TObject);
const
  Pattern = '(\w+)\@(\w+)((\.[a-z]+){1,2})$';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TCrudPerson.EditLastNameExit(Sender: TObject);
const
  Pattern = '^[a-zA-Z\s]+$';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TCrudPerson.EditNameExit(Sender: TObject);
const
  Pattern = '^[a-zA-Z\s]+$';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TCrudPerson.EditPhoneExit(Sender: TObject);
const
  Pattern = '^\(\d{2}\)(\s|)(\d{4}|\d{5})\-\d{4}$';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TCrudPerson.ModelToView;
begin
  if GetModel = nil then
    Exit;

  EditName.Text              := GetModel.Name;
  EditLastName.Text          := GetModel.LastName;
  EditPhone.Text             := GetModel.Phone;
  EditEmail.Text             := GetModel.Email;
  EditCPF.Text               := GetModel.CPF;
  EditBirth.Date             := GetModel.Birth;
  RadioGroupGender.ItemIndex := Ord(GetModel.Gender);
end;

function TCrudPerson.ModelToArray: TArray<string>;
type
  TGridColumn = (gcName, gcLastName, gcCPF, gcPhone, gcEmail);
begin
  SetLength(Result, Succ(Ord(High(TGridColumn))));

  Result[Ord(gcName)]     := GetModel.Name;
  Result[Ord(gcLastName)] := GetModel.LastName;
  Result[Ord(gcCPF)]      := GetModel.CPF;
  Result[Ord(gcPhone)]    := GetModel.Phone;
  Result[Ord(gcEmail)]    := GetModel.Email;
end;

procedure TCrudPerson.ViewToModel;
begin
  GetModel.Name     := EditName.Text;
  GetModel.LastName := EditLastName.Text;
  GetModel.Phone    := EditPhone.Text;
  GetModel.Gender   := TGender(RadioGroupGender.ItemIndex);
  GetModel.Email    := EditEmail.Text;
  GetModel.CPF      := EditCPF.Text;
  GetModel.Birth    := EditBirth.Date;
end;

function TCrudPerson.GetModel: TPerson;
begin
  Result := TPerson(inherited GetModel);
end;

function TCrudPerson.DefineRequiredControls: TArray<TWinControl>;
begin
  Result := [
    EditName,
    EditLastName,
    RadioGroupGender,
    EditBirth,
    EditPhone,
    EditEmail,
    EditCPF];
end;

end.

