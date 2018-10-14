unit Forms.Exercise1;

interface

uses
  Forms.Crud,
  Helpers.DateTime,
  Model.Gender,
  Model.Person,
  System.Actions,
  System.Classes,
  System.Math,
  System.SysUtils,
  System.Types,
  Utils.Collections.API,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Mask,
  Vcl.StdCtrls;

type
  TExercise1 = class(TCrud)
    GroupBoxData: TGroupBox;
    LabelPhone: TLabel;
    LabelBirth: TLabel;
    LabeledEditName: TLabeledEdit;
    MaskEditPhone: TMaskEdit;
    RadioGroupGender: TRadioGroup;
    LabeledEditLastName: TLabeledEdit;
    GroupBoxIndex: TGroupBox;
    LabelCount: TLabel;
    EditCount: TEdit;
    DateTimePickerBirth: TDateTimePicker;
    EditIndex: TEdit;
    procedure DateTimePickerBirthExit(Sender: TObject);
    procedure EditIndexExit(Sender: TObject);
  private
    FArray: ICollection<TPerson>;
    { Getters and setters }
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetIndex: Integer;
    procedure SetIndex(const Value: Integer);
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
    procedure ModelToView(const Model: TPerson);
  protected
    { Crud actions }
    procedure Insert; override;
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
    property Count: Integer read GetCount write SetCount;
    property Index: Integer read GetIndex write SetIndex;
    property Name: string read GetName write SetName;
    property LastName: string read GetLastName write SetLastName;
    property Birth: TDateTime read GetBirth write SetBirth;
    property Phone: string read GetPhone write SetPhone;
    property Gender: TGender read GetGender write SetGender;
  end;

implementation

{$R *.dfm}

uses
  Utils.Messages,
  Utils.Collections.DynamicArray;

{ TCrud1 }

procedure TExercise1.Clear;
begin
  Name := string.Empty;
  LastName := string.Empty;
  Birth := TDateTime.Null;
  Phone := string.Empty;
  Gender := TGender.geUndefined;
end;

procedure TExercise1.ControlActions;
begin
  ActionEdit.Enabled := not FArray.IsEmpty;
  ActionRemove.Enabled := not FArray.IsEmpty;
end;

constructor TExercise1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
  Count := ZeroValue;
end;

procedure TExercise1.DateTimePickerBirthExit(Sender: TObject);
begin
  inherited;
  if (Sender as TDateTimePicker).DateTime.Compare(TDateTime.Now) = GreaterThanValue then
    TMessage.Warning('Data inválida');
end;

procedure TExercise1.DefineRequiredComponents;
begin
  inherited;
  Self.DefineRequiredComponents([
    LabeledEditName,
    LabeledEditLastName,
    DateTimePickerBirth,
    MaskEditPhone]);
end;

procedure TExercise1.Edit;
begin
  inherited;
end;

procedure TExercise1.EditIndexExit(Sender: TObject);
begin
  inherited;
  if FArray.InRange(Index) then
  begin
    ModelToView(FArray.Item[Index]);
    Exit;
  end;
  TMessage.Information('O índice [%d] não existe no array.', [Index]);
  Index := FArray.Count;
end;

procedure TExercise1.Insert;
var
  NewIndex: Integer;
begin
  NewIndex := FArray.Add(ViewToModel);
  Count := NewIndex;
  Index := NewIndex;
  inherited;
end;

procedure TExercise1.Remove;
begin
  FArray.Remove(FArray.Item[Index]);
  inherited;
end;

procedure TExercise1.ModelToView(const Model: TPerson);
begin
  Clear;

  if not Assigned(Model) then
    Exit;

  Name := Model.Name;
  LastName := Model.LastName;
  Birth := Model.Birth;
  Phone := Model.Phone;
  Gender := Model.Gender;
end;

function TExercise1.ViewToModel: TPerson;
begin
  Result := TPerson.Create;
  Result.Name := Name;
  Result.LastName := LastName;
  Result.Birth := Birth;
  Result.Phone := Phone;
  Result.Gender := Gender;
end;

function TExercise1.GetInitialFocus: TWinControl;
begin
  Result := LabeledEditName;
end;

function TExercise1.GetBirth: TDateTime;
begin
  Result := DateTimePickerBirth.DateTime;
end;

function TExercise1.GetCount: Integer;
begin
  Result := StrToIntDef(EditCount.Text, ZeroValue);
end;

function TExercise1.GetGender: TGender;
begin
  Result := TGender(RadioGroupGender.ItemIndex);
end;

function TExercise1.GetIndex: Integer;
begin
  Result := StrToIntDef(EditIndex.Text, ZeroValue)
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
  Result := MaskEditPhone.Text;
end;

procedure TExercise1.SetBirth(const Value: TDateTime);
begin
  DateTimePickerBirth.DateTime := Value;
end;

procedure TExercise1.SetCount(const Value: Integer);
begin
  EditCount.Text := Value.ToString;
end;

procedure TExercise1.SetGender(const Value: TGender);
begin
  RadioGroupGender.ItemIndex := Ord(Value);
end;

procedure TExercise1.SetIndex(const Value: Integer);
begin
  EditIndex.Text := Value.ToString;
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
  MaskEditPhone.Text := Value;
end;

end.
