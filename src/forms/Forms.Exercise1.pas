unit Forms.Exercise1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Forms.Crud, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.Buttons, Utils.DynamicArrayInterface,
  Model.Person, Model.Gender, System.Math;

type
  TExercise1 = class(TCrud)
    GroupBoxData: TGroupBox;
    LabelPhone: TLabel;
    LabelBirth: TLabel;
    LabeledEditName: TLabeledEdit;
    MaskEditPhone: TMaskEdit;
    RadioGroupGender: TRadioGroup;
    LabeledEditLastName: TLabeledEdit;
    MaskEditBirth: TMaskEdit;
    GroupBoxIndex: TGroupBox;
    LabelCount: TLabel;
    EditCount: TEdit;
    LabeledEditIndex: TLabeledEdit;
    ActionIndexExit: TAction;
    procedure ActionIndexExitExecute(Sender: TObject);
  private
    FArray: IDynamicArray<TPerson>;
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
    procedure DefineMandatoryComponents; override;
    { Other useful methods }
    procedure Clear; override;
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
  Utils.DynamicArray;

{ TCrud1 }

procedure TExercise1.ActionIndexExitExecute(Sender: TObject);
begin
  inherited;
  ModelToView(FArray.Item[Index]);
end;

procedure TExercise1.Clear;
begin
  Name := string.Empty;
  LastName := string.Empty;
  Birth := ZeroValue;
  Phone := string.Empty;
  Gender := TGender.geUndefined;
end;

constructor TExercise1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
  Count := ZeroValue;
end;

procedure TExercise1.DefineMandatoryComponents;
begin
  inherited;
  Self.DefineMandatoryComponents([
    LabeledEditName,
    LabeledEditLastName,
    MaskEditBirth,
    MaskEditPhone]);
end;

procedure TExercise1.Edit;
begin
  inherited;
end;

procedure TExercise1.Insert;
begin
  inherited;
  FArray.Insert(ViewToModel);
  Count := FArray.Count;
  Index := FArray.Count;
end;

procedure TExercise1.Remove;
begin
  FArray.Remove(FArray.Item[Index]);
  inherited;
end;

function TExercise1.GetBirth: TDateTime;
begin
  Result := StrToDateDef(MaskEditBirth.Text, ZeroValue);
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
  Result := StrToIntDef(LabeledEditIndex.Text, ZeroValue)
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

procedure TExercise1.ModelToView(const Model: TPerson);
begin
  if not Assigned(Model) then
  begin
    Clear;
    Exit;
  end;

  Name := Model.Name;
  LastName := Model.LastName;
  Birth := Model.Birth;
  Phone := Model.Phone;
  Gender := Model.Gender;
end;

procedure TExercise1.SetBirth(const Value: TDateTime);
begin
  MaskEditBirth.Text := DateToStr(Value);
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
  LabeledEditIndex.Text := Value.ToString;
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

function TExercise1.ViewToModel: TPerson;
begin
  Result := TPerson.Create;
  Result.Name := Name;
  Result.LastName := LastName;
  Result.Birth := Birth;
  Result.Phone := Phone;
  Result.Gender := Gender;
end;

end.
