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
    EditBirth: TDateTimePicker;
    LabelBirth: TLabel;
    LabelPhone: TLabel;
    EditPhone: TEdit;
    LabelEmail: TLabel;
    EditEmail: TEdit;
    LabelCPF: TLabel;
    EditCPF: TEdit;
    RadioGroupGender: TRadioGroup;
    procedure EditBirthExit(Sender: TObject);
    procedure EditNameExit(Sender: TObject);
    procedure EditEmailExit(Sender: TObject);
    procedure EditCPFExit(Sender: TObject);
    procedure EditPhoneExit(Sender: TObject);
    procedure EditLastNameExit(Sender: TObject);
  protected
    procedure Initialize; override;
    {}
    procedure ViewToModel; override;
    procedure ModelToView; override;
    function ModelToArray: TArray<string>; override;

    { Other }
    function DefineRequiredControls: TArray<TWinControl>; override;

    function CreateModel: TObject; override;
    function GetModel: TPerson; reintroduce;
  end;

implementation

{$R *.dfm}

{ TCrudPerson }

procedure TCrudPerson.EditBirthExit(Sender: TObject);
var
  Birth: TDateTime;
begin
  inherited;
  Birth := (Sender as TDateTimePicker).DateTime;
  if CompareDateTime(Birth, Today) = GreaterThanValue then
    TMessage.Warning('Data inválida');
end;

function TCrudPerson.CreateModel: TObject;
begin
  Result := TPerson.Create;
end;

procedure TCrudPerson.Initialize;
const
  Titles: TArray<string> = ['Nome', 'Sobrenome', 'CPF', 'Telefone'];
begin
  inherited;
  Grid.AddHeader(Titles);
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
  Pattern = '\w+@\w+\.[a-z]+';
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
  Pattern = '\(\d{2}\)(\s|)(\d{4}|\d{5})\-\d{4}';
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
  EditBirth.DateTime         := GetModel.Birth;
  EditPhone.Text             := GetModel.Phone;
  EditEmail.Text             := GetModel.Email;
  EditCPF.Text               := GetModel.CPF;
  RadioGroupGender.ItemIndex := Ord(GetModel.Gender);
end;

function TCrudPerson.ModelToArray: TArray<string>;
type
  TGridColumn = (gcName, gcLastName, gcCPF, gcPhone);
begin
  SetLength(Result, Ord(High(TGridColumn)));

  Result[Ord(gcName)]     := GetModel.Name;
  Result[Ord(gcLastName)] := GetModel.LastName;
  Result[Ord(gcCPF)]      := GetModel.CPF;
  Result[Ord(gcPhone)]    := GetModel.Phone;
end;

procedure TCrudPerson.ViewToModel;
begin
  GetModel.Name     := EditName.Text;
  GetModel.LastName := EditLastName.Text;
  GetModel.Birth    := EditBirth.DateTime;
  GetModel.Phone    := EditPhone.Text;
  GetModel.Gender   := TGender(RadioGroupGender.ItemIndex);
  GetModel.Email    := EditEmail.Text;
  GetModel.CPF      := EditCPF.Text;
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

