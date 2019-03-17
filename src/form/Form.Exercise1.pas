unit Form.Exercise1;

interface

uses
  Collections.API,
  Collections.DynamicArray,
  Form.Crud,
  Helper.DateTime,
  Model.Gender,
  Model.Person,
  System.Actions,
  System.Classes,
  System.Math,
  System.SysUtils,
  System.Types,
  Util.Messages,
  Util,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Helpers,
  Vcl.StdCtrls;

type
  TExercise1 = class(TCrud)
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
  private
    FArray: ICollection<TPerson>;
  protected
    procedure Initialize; override;

    function Save: Boolean; override;
    procedure Remove; override;
    {}
    procedure ViewToModel; override;
    procedure ModelToView; override;
    function ModelToArray: TArray<string>; override;

    { Other }
    function DefineInitialFocus: TWinControl; override;
    function DefineRequiredControls: TArray<TWinControl>; override;

    function CreateModel: TObject; override;
    function GetModel: TPerson; reintroduce; overload;
    function GetModel(const Row: Integer): TObject; overload; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

{ TExercise1 }

constructor TExercise1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
end;

procedure TExercise1.EditBirthExit(Sender: TObject);
var
  Birth: TDateTime;
begin
  inherited;
  Birth := (Sender as TDateTimePicker).DateTime;
  if Birth.Compare(TDateTime.Now) = GreaterThanValue then
    TMessage.Warning('Data inválida');
end;

function TExercise1.CreateModel: TObject;
begin
  Result := TPerson.Create;
end;

procedure TExercise1.Initialize;
const
  Titles: TArray<string> = ['Nome', 'Sobrenome', 'CPF', 'Telefone'];
begin
  inherited;
  Grid.AddHeader(Titles);
end;

function TExercise1.Save: Boolean;
begin
  Result := inherited Save;
  if Result then
    FArray.Add(GetModel);
end;

procedure TExercise1.EditCPFExit(Sender: TObject);
const
  Pattern = '\d{3}.\d{3}.\d{3}-\d{2}';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TExercise1.EditEmailExit(Sender: TObject);
const
  Pattern = '\w+@\w+\.[a-z]+';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TExercise1.EditNameExit(Sender: TObject);
const
  Pattern = '^[a-zA-Z\s]+$';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TExercise1.EditPhoneExit(Sender: TObject);
const
  Pattern = '\(\d{2}\)(\s|)(\d{4}|\d{5})\-\d{4}';
begin
  inherited;
  RegExValidate(Sender, Pattern);
end;

procedure TExercise1.ModelToView;
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

procedure TExercise1.Remove;
begin
  if FArray.Remove(GetModel(Grid.Row) as TPerson) then
    inherited Remove;
end;

function TExercise1.ModelToArray: TArray<string>;
type
  TGridColumn = (gcName, gcLastName, gcCPF, gcPhone);
var
  Values: array[TGridColumn] of string;
begin
  Values[gcName]     := GetModel.Name;
  Values[gcLastName] := GetModel.LastName;
  Values[gcCPF]      := GetModel.CPF;
  Values[gcPhone]    := GetModel.Phone;

  Result := TUtil.Methods.ArrayOfToTArray(Values);
end;

procedure TExercise1.ViewToModel;
begin
  GetModel.Name     := EditName.Text;
  GetModel.LastName := EditLastName.Text;
  GetModel.Birth    := EditBirth.DateTime;
  GetModel.Phone    := EditPhone.Text;
  GetModel.Gender   := TGender(RadioGroupGender.ItemIndex);
  GetModel.Email    := EditEmail.Text;
  GetModel.CPF      := EditCPF.Text;
end;

function TExercise1.DefineInitialFocus: TWinControl;
begin
  Result := EditName;
end;

function TExercise1.GetModel(const Row: Integer): TObject;
begin
  Result := FArray.Item[Pred(Row)];
end;

function TExercise1.GetModel: TPerson;
begin
  Result := TPerson(inherited GetModel);
end;

function TExercise1.DefineRequiredControls: TArray<TWinControl>;
begin
  Result := [
    EditName,
    EditLastName//,
  //  RadioGroupGender,
  //  EditBirth,
  //  EditPhone,
  //  EditEmail,
  //  EditCPF
  ];
end;

end.

