unit Forms.ExerciseOne;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Math,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Mask,
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  Utils.DynamicArrayInterface,
  Model.Person,
  Model.Gender;

type
  TExerciseOne = class(TForm)
    GroupBoxData: TGroupBox;
    ButtonInsert: TButton;
    ActionList: TActionList;
    ActionInsert: TAction;
    LabeledEditName: TLabeledEdit;
    ActionIndexExit: TAction;
    ActionRemove: TAction;
    ButtonRemove: TButton;
    MaskEditPhone: TMaskEdit;
    LabelPhone: TLabel;
    GroupBoxIndex: TGroupBox;
    RadioGroupGender: TRadioGroup;
    LabelCount: TLabel;
    EditCount: TEdit;
    LabeledEditIndex: TLabeledEdit;
    LabeledEditLastName: TLabeledEdit;
    MaskEditBirth: TMaskEdit;
    LabelBirth: TLabel;
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionIndexExitExecute(Sender: TObject);
    procedure ActionRemoveExecute(Sender: TObject);
  private
    FArray: IDynamicArray<TPerson>;

    { Methods }
    function ViewToModel: TPerson;
    procedure ModelToView(const Model: TPerson);
    procedure ClearView;

    { Getters and Setters }
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

{ TExerciseOne }

constructor TExerciseOne.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArray := TDynamicArray<TPerson>.Create;
  Count := ZeroValue;
end;

procedure TExerciseOne.ClearView;
begin
  Name := string.Empty;
  LastName := string.Empty;
  Birth := ZeroValue;
  Phone := string.Empty;
  Gender := TGender.geUndefined;
end;

procedure TExerciseOne.ActionIndexExitExecute(Sender: TObject);
begin
  ModelToView(FArray.Item[Index]);
end;

procedure TExerciseOne.ActionInsertExecute(Sender: TObject);
var
  Element: TPerson;
begin
  Element := ViewToModel;
  FArray.Insert(Element);
  Count := FArray.IndexOf(Element);
  Index := Count;
end;

procedure TExerciseOne.ActionRemoveExecute(Sender: TObject);
begin
  FArray.Remove(FArray.Item[Index]);
  ClearView;
end;

function TExerciseOne.GetBirth: TDateTime;
begin
  Result := StrToDate(MaskEditBirth.Text);
end;

function TExerciseOne.GetCount: Integer;
begin
  Result := StrToIntDef(EditCount.Text, ZeroValue);
end;

function TExerciseOne.GetGender: TGender;
begin
  Result := TGender(RadioGroupGender.ItemIndex);
end;

function TExerciseOne.GetIndex: Integer;
begin
  Result := StrToIntDef(LabeledEditIndex.Text, ZeroValue)
end;

function TExerciseOne.GetLastName: string;
begin
  Result := LabeledEditLastName.Text;
end;

function TExerciseOne.GetName: string;
begin
  Result := LabeledEditName.Text;
end;

function TExerciseOne.GetPhone: string;
begin
  Result := MaskEditPhone.Text;
end;

procedure TExerciseOne.ModelToView(const Model: TPerson);
begin
  if not Assigned(Model) then
  begin
    ClearView;
    Exit;
  end;

  Name := Model.Name;
  LastName := Model.LastName;
  Birth := Model.Birth;
  Phone := Model.Phone;
  Gender := Model.Gender;
end;

procedure TExerciseOne.SetBirth(const Value: TDateTime);
begin
  MaskEditBirth.Text := DateToStr(Value);
end;

procedure TExerciseOne.SetCount(const Value: Integer);
begin
  EditCount.Text := Value.ToString;
end;

procedure TExerciseOne.SetGender(const Value: TGender);
begin
  RadioGroupGender.ItemIndex := Ord(Value);
end;

procedure TExerciseOne.SetIndex(const Value: Integer);
begin
  LabeledEditIndex.Text := Value.ToString;
end;

procedure TExerciseOne.SetLastName(const Value: string);
begin
  LabeledEditLastName.Text := Value;
end;

procedure TExerciseOne.SetName(const Value: string);
begin
  LabeledEditName.Text := Value;
end;

procedure TExerciseOne.SetPhone(const Value: string);
begin
  MaskEditPhone.Text := Value;
end;

function TExerciseOne.ViewToModel: TPerson;
begin
  Result := TPerson.Create;
  Result.Name := Name;
  Result.LastName := LastName;
  Result.Birth := Birth;
  Result.Phone := Phone;
  Result.Gender := Gender;
end;

end.
