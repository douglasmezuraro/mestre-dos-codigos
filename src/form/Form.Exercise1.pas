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
    PageControlLayout: TPageControl;
    TabSheetList: TTabSheet;
    TabSheetData: TTabSheet;
    RadioGroupGender: TRadioGroup;
    EditPhone: TLabeledEdit;
    EditEmail: TLabeledEdit;
    EditBirth: TDateTimePicker;
    EditCPF: TLabeledEdit;
    LabelBirth: TLabel;
    EditName: TLabeledEdit;
    EditLastName: TLabeledEdit;
    Grid: TStringGrid;
    procedure EditBirthExit(Sender: TObject);
    procedure EditNameExit(Sender: TObject);
    procedure EditEmailExit(Sender: TObject);
    procedure EditCPFExit(Sender: TObject);
    procedure EditPhoneExit(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private type
    TPersonColumn = (pcName, pcLastName, pcCPF, pcPhone);
  private
    FArray: ICollection<TPerson>;
    FModel: TPerson;
    FPrevRow: Byte;
    { Methods }
    procedure ViewToModel;
    procedure ModelToView;
    function ModelToArray: TArray<string>;
  protected
    procedure Initialize; override;

    { Main actions }
    function Insert: Boolean; override;
    procedure Edit; override;
    procedure Remove; override;

    { Other }
    function GetInitialFocus: TWinControl; override;
    function GetRequiredControls: TArray<TWinControl>; override;
    procedure ControlActions; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Model: TPerson read FModel write FModel;
  end;

implementation

{$R *.dfm}

{ TExercise1 }

procedure TExercise1.ControlActions;
begin
  ActionEdit.Enabled := FPrevRow <> Grid.HeaderIndex;
  ActionRemove.Enabled := FPrevRow <> Grid.HeaderIndex;
end;

constructor TExercise1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
  FPrevRow := Grid.Row;
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

procedure TExercise1.Edit;
begin
  ViewToModel;
  Grid.Update(ModelToArray);
end;

procedure TExercise1.Initialize;
const
  Titles: TArray<string> = ['Nome', 'Sobrenome', 'CPF', 'Telefone'];
begin
  inherited;
  Grid.Add(Titles, Grid.HeaderIndex);
end;

function TExercise1.Insert: Boolean;
begin
  Result := inherited Insert;

  if not Result then
    Exit;

  Model := TPerson.Create;
  ViewToModel;
  Result := FArray.Add(Model) > NegativeValue;

  if not Result then
    Exit;

  Grid.Add(ModelToArray);
  PageControlLayout.ActivePage := TabSheetList;
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

procedure TExercise1.Remove;
begin
  if FArray.Remove(FArray.Item[Pred(Grid.Row)]) then
  begin
    Grid.Remove;
    inherited;
  end;
end;

procedure TExercise1.ModelToView;
begin
  if not Assigned(Model) then
    Exit;

  EditName.Text              := Model.Name;
  EditLastName.Text          := Model.LastName;
  EditBirth.DateTime         := Model.Birth;
  EditPhone.Text             := Model.Phone;
  EditEmail.Text             := Model.Email;
  EditCPF.Text               := Model.CPF;
  RadioGroupGender.ItemIndex := Ord(Model.Gender);
end;

function TExercise1.ModelToArray: TArray<string>;
begin
  SetLength(Result, Grid.ColCount);

  Result[Ord(pcName)]     := Model.Name;
  Result[Ord(pcLastName)] := Model.LastName;
  Result[Ord(pcCPF)]      := Model.CPF;
  Result[Ord(pcPhone)]    := Model.Phone;
end;

procedure TExercise1.ViewToModel;
begin
  Model.Name     := EditName.Text;
  Model.LastName := EditLastName.Text;
  Model.Birth    := EditBirth.DateTime;
  Model.Phone    := EditPhone.Text;
  Model.Gender   := TGender(RadioGroupGender.ItemIndex);
  Model.Email    := EditEmail.Text;
  Model.CPF      := EditCPF.Text;
end;

function TExercise1.GetInitialFocus: TWinControl;
begin
  Result := EditName;
end;

function TExercise1.GetRequiredControls: TArray<TWinControl>;
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

procedure TExercise1.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  if ARow = FPrevRow then
    Exit;

  (Sender as TStringGrid).OnSelectCell := nil;
  try
    Model := FArray.Item[Pred(ARow)];
    ModelToView;
    FPrevRow := ARow;
    ControlActions;
  finally
    (Sender as TStringGrid).OnSelectCell := GridSelectCell;
  end;
end;

end.

