unit Form.Exercise1;

interface

uses
  Form.Crud,
  Helper.DateTime,
  Helper.WinControl,
  Helper.StringGrid,
  Model.Gender,
  Model.Person,
  System.Actions,
  System.Classes,
  System.Math,
  System.SysUtils,
  System.Types,
  Collections.API,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.StdCtrls,
  Util.Messages,
  Collections.DynamicArray;

type
  TExercise1 = class(TCrud)
    PageControlLayout: TPageControl;
    TabSheetList: TTabSheet;
    TabSheetData: TTabSheet;
    RadioGroupGender: TRadioGroup;
    LabeledEditPhone: TLabeledEdit;
    LabeledEditEmail: TLabeledEdit;
    DateTimePickerBirth: TDateTimePicker;
    LabeledEditCPF: TLabeledEdit;
    LabelBirth: TLabel;
    LabeledEditName: TLabeledEdit;
    LabeledEditLastName: TLabeledEdit;
    Grid: TStringGrid;
    procedure DateTimePickerBirthExit(Sender: TObject);
    procedure LabeledEditNameExit(Sender: TObject);
    procedure LabeledEditEmailExit(Sender: TObject);
    procedure LabeledEditCPFExit(Sender: TObject);
    procedure LabeledEditPhoneExit(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private type
    TFormPage = (fpList, fpData);
    TPersonColumn = (pcName, pcLastName, pcCPF, pcPhone);
  private
    FArray: ICollection<TPerson>;
    FPrevRow: Byte;
    { Getters and setters }
    function GetName: string;
    procedure SetName(const Value: string); reintroduce;
    function GetLastName: string;
    procedure SetLastName(const Value: string);
    function GetPhone: string;
    procedure SetPhone(const Value: string);
    function GetBirth: TDateTime;
    procedure SetBirth(const Value: TDateTime);
    function GetGender: TGender;
    procedure SetGender(const Value: TGender);
    { Methods }
    function ViewToModel: TPerson;
    function ViewToArray: TArray<string>;
    procedure ModelToView(const Model: TPerson);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
    function GetCPF: string;
    procedure SetCPF(const Value: string);
  protected
    procedure Initialize; override;
    { Crud actions }
    function Insert: Boolean; override;
    procedure Edit; override;
    procedure Remove; override;
    { Mandatory componentes }
    procedure DefineRequiredComponents; override;
    { Other useful methods }
    procedure Clear; override;
    procedure ControlActions; override;
    function GetInitialFocus: TWinControl; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Name: string read GetName write SetName;
    property LastName: string read GetLastName write SetLastName;
    property Birth: TDateTime read GetBirth write SetBirth;
    property Phone: string read GetPhone write SetPhone;
    property Gender: TGender read GetGender write SetGender;
    property Email: string read GetEmail write SetEmail;
    property CPF: string read GetCPF write SetCPF;
  end;

implementation

{$R *.dfm}

{ TExercise1 }

procedure TExercise1.Clear;
begin
  Name := string.Empty;
  LastName := string.Empty;
  Birth := TDateTime.Null;
  Phone := string.Empty;
  Gender := TGender.geUndefined;
  Email := string.Empty;
  CPF := string.Empty;
end;

procedure TExercise1.ControlActions;
begin
  ActionEdit.Enabled := Grid.Row <> Grid.HeaderIndex;
  ActionRemove.Enabled := Grid.Row <> Grid.HeaderIndex;
end;

constructor TExercise1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
  FPrevRow := Grid.Row;
end;

procedure TExercise1.DateTimePickerBirthExit(Sender: TObject);
var
  Birth: TDateTime;
begin
  inherited;
  Birth := (Sender as TDateTimePicker).DateTime;
  if Birth.Compare(TDateTime.Now) = GreaterThanValue then
    TMessage.Warning('Data inválida');
end;

procedure TExercise1.DefineRequiredComponents;
begin
  inherited;
  DefineRequiredComponents([
    LabeledEditName,
    LabeledEditLastName
//    ,
//    DateTimePickerBirth,
//    LabeledEditPhone,
//    LabeledEditEmail,
//    LabeledEditCPF
  ]);
end;

procedure TExercise1.Edit;
begin
  inherited;
end;

procedure TExercise1.Initialize;
const
  Titles: TArray<string> = ['Nome', 'Sobrenome', 'CPF', 'Telefone'];
begin
  inherited;
  Grid.Add(Titles, True);
end;

function TExercise1.Insert: Boolean;
var
  Model: TPerson;
begin
  Result := inherited Insert;

  if not Result then
    Exit;

  Model := ViewToModel;
  Result := FArray.Add(Model) > NegativeValue;

  if not Result then
    Exit;

  Grid.Add(ViewToArray);
  PageControlLayout.ActivePage := TabSheetList;
end;

procedure TExercise1.LabeledEditCPFExit(Sender: TObject);
const
  Pattern = '\d{3}.\d{3}.\d{3}-\d{2}';
begin
  inherited;
  Validate(Sender, Pattern);
end;

procedure TExercise1.LabeledEditEmailExit(Sender: TObject);
const
  Pattern = '\w+@\w+\.[a-z]+';
begin
  inherited;
  Validate(Sender, Pattern);
end;

procedure TExercise1.LabeledEditNameExit(Sender: TObject);
const
  Pattern = '^[a-zA-Z\s]+$';
begin
  inherited;
  Validate(Sender, Pattern);
end;

procedure TExercise1.LabeledEditPhoneExit(Sender: TObject);
const
  Pattern = '\(\d{2}\)(\s|)(\d{4}|\d{5})\-\d{4}';
begin
  inherited;
  Validate(Sender, Pattern);
end;

procedure TExercise1.Remove;
begin
  FArray.Remove(FArray.Item[Pred(Grid.Row)]);
  Grid.Remove;
  inherited;
end;

procedure TExercise1.ModelToView(const Model: TPerson);
begin
  Clear;

  if not Assigned(Model) then
    Exit;

  Name     := Model.Name;
  LastName := Model.LastName;
  Birth    := Model.Birth;
  Phone    := Model.Phone;
  Gender   := Model.Gender;
  Email    := Model.Email;
  CPF      := Model.CPF;
end;

function TExercise1.ViewToArray: TArray<string>;
begin
  SetLength(Result, Succ(Ord(High(TPersonColumn))));
  Result[Ord(pcName)]     := Name;
  Result[Ord(pcLastName)] := LastName;
  Result[Ord(pcCPF)]      := CPF;
  Result[Ord(pcPhone)]    := Phone;
end;

function TExercise1.ViewToModel: TPerson;
begin
  Result := TPerson.Create;
  Result.Name := Name;
  Result.LastName := LastName;
  Result.Birth := Birth;
  Result.Phone := Phone;
  Result.Gender := Gender;
  Result.Email := Email;
  Result.CPF := CPF;
end;

function TExercise1.GetInitialFocus: TWinControl;
begin
  Result := LabeledEditName;
end;

function TExercise1.GetBirth: TDateTime;
begin
  Result := DateTimePickerBirth.DateTime;
end;

function TExercise1.GetCPF: string;
begin
  Result := LabeledEditCPF.Text;
end;

function TExercise1.GetEmail: string;
begin
  Result := LabeledEditEmail.Text;
end;

function TExercise1.GetGender: TGender;
begin
  Result := TGender(RadioGroupGender.ItemIndex);
end;

function TExercise1.GetLastName: string;
begin
  Result := LabeledEditLastName.Text;
end;

function TExercise1.GetName: string;
begin
  Result := LabeledEditName.Text;
end;

function TExercise1.GetPhone: string;
begin
  Result := LabeledEditPhone.Text;
end;

procedure TExercise1.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  Model: TPerson;
begin
  inherited;
  if ARow = FPrevRow then
    Exit;

  (Sender as TStringGrid).OnSelectCell := nil;
  try
    Model := FArray.Item[Pred(ARow)];
    ModelToView(Model);
    FPrevRow := ARow;
  finally
    (Sender as TStringGrid).OnSelectCell := GridSelectCell;
  end;
end;

procedure TExercise1.SetBirth(const Value: TDateTime);
begin
  DateTimePickerBirth.DateTime := Value;
end;

procedure TExercise1.SetCPF(const Value: string);
begin
  LabeledEditCPF.Text := Value;
end;

procedure TExercise1.SetEmail(const Value: string);
begin
  LabeledEditEmail.Text := Value;
end;

procedure TExercise1.SetGender(const Value: TGender);
begin
  RadioGroupGender.ItemIndex := Ord(Value);
end;

procedure TExercise1.SetLastName(const Value: string);
begin
  LabeledEditLastName.Text := Value;
end;

procedure TExercise1.SetName(const Value: string);
begin
  LabeledEditName.Text := Value;
end;

procedure TExercise1.SetPhone(const Value: string);
begin
  LabeledEditPhone.Text := Value;
end;

end.

