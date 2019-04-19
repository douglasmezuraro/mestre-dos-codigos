unit Form;

interface

uses
  API,
  CalculationType,
  ExtensiveNumber,
  GeometricForm,
  System.Actions,
  System.Classes,
  System.SysUtils,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    ActionCalculate: TAction;
    ActionList: TActionList;
    EditInputA: TLabeledEdit;
    EditInputB: TLabeledEdit;
    RadioGroupCalculationType: TRadioGroup;
    RadioGroupGeometricFigure: TRadioGroup;
    EditOutput: TLabeledEdit;
    ButtonCalculate: TButton;
    MemoOutput: TMemo;
    procedure FormShow(Sender: TObject);
    procedure ActionCalculateExecute(Sender: TObject);
    procedure RadioGroupGeometricFigureClick(Sender: TObject);
  private
    FExtensiveNumber: TExtensiveNumber;

    function GetGeometricForm: TGeometricForm;
    procedure SetGeometricForm(const Value: TGeometricForm);
    function GetInputA: Extended;
    procedure SetInputA(const Value: Extended);
    function GetInputB: Extended;
    procedure SetInputB(const Value: Extended);
    function GetCalculationType: TCalculationType;
    procedure SetCalculationType(const Value: TCalculationType);
    function GetNumberOutput: Extended;
    procedure SetNumberOutput(const Value: Extended);
    function GetStringOutput: string;
    procedure SetStringOutput(const Value: string);

    function Calculate: Extended;
    procedure Initialize;
    function ArrayOfToTArray<T>(const Values: array of T): TArray<T>;
    procedure ValidateInput;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    property GeometricForm: TGeometricForm read GetGeometricForm write SetGeometricForm;
    property CalculationType: TCalculationType read GetCalculationType write SetCalculationType;
    property InputA: Extended read GetInputA write SetInputA;
    property InputB: Extended read GetInputB write SetInputB;
    property NumberOutput: Extended read GetNumberOutput write SetNumberOutput;
    property StringOutput: string read GetStringOutput write SetStringOutput;
  end;

implementation

{$R *.dfm}

constructor TMainForm.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FExtensiveNumber := TExtensiveNumber.Create;
end;

destructor TMainForm.Destroy;
begin
  FExtensiveNumber.Free;
  inherited;
end;

procedure TMainForm.ActionCalculateExecute(Sender: TObject);
begin
  NumberOutput := Calculate;
  StringOutput := FExtensiveNumber.Format(InputA);
end;

function TMainForm.ArrayOfToTArray<T>(const Values: array of T): TArray<T>;
var
  Index: Integer;
  Size: Integer;
begin
  Size := Length(Values);
  SetLength(Result, Size);
  for Index := 0 to Pred(Size) do
  begin
    Result[Index] := Values[Index];
  end;
end;

function TMainForm.Calculate: Extended;
begin
  Result := 0;

  ValidateInput;

  case CalculationType of
    ctArea:
      begin
        case GeometricForm of
          gfSquare: Result := SquareArea(InputA) ;
          gfCircle: Result := CircleArea(InputA);
          gfRectangle: Result := RectangleArea(InputA, InputB);
          gfEquilateralTriangle: Result := EquilateralTriangleArea(InputA);
        end;
      end;
    ctPerimeter:
      begin
        case GeometricForm of
          gfSquare: Result := SquarePerimeter(InputA);
          gfCircle: Result := CirclePerimeter(InputA);
          gfRectangle: Result := RectanglePerimeter(InputA, InputB);
          gfEquilateralTriangle: Result := EquilateralTrianglePerimeter(InputA);
        end;
      end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Initialize;
end;

function TMainForm.GetCalculationType: TCalculationType;
begin
  Result := TCalculationType(RadioGroupCalculationType.ItemIndex);
end;

function TMainForm.GetGeometricForm: TGeometricForm;
begin
  Result := TGeometricForm(RadioGroupGeometricFigure.ItemIndex);
end;

function TMainForm.GetInputA: Extended;
begin
  Result := StrToFloatDef(EditInputA.Text, 0);
end;

function TMainForm.GetInputB: Extended;
begin
  Result := StrToFloatDef(EditInputB.Text, 0);
end;

function TMainForm.GetNumberOutput: Extended;
begin
  Result := StrToFloatDef(EditOutput.Text, 0);
end;

function TMainForm.GetStringOutput: string;
begin
  Result := MemoOutput.Lines.CommaText;
end;

procedure TMainForm.Initialize;
begin
  RadioGroupGeometricFigure.Items.AddStrings(ArrayOfToTArray(GeometricFormMap));
  RadioGroupCalculationType.Items.AddStrings(ArrayOfToTArray(CalculationTypeMap));

  RadioGroupGeometricFigure.ItemIndex := Ord(TGeometricForm.gfSquare);
  RadioGroupCalculationType.ItemIndex := Ord(TCalculationType.ctArea);
end;

procedure TMainForm.RadioGroupGeometricFigureClick(Sender: TObject);
begin
  EditInputA.EditLabel.Caption := GeometricInputCaptionMap[GeometricForm];
  EditInputB.EditLabel.Caption := EditInputA.EditLabel.Caption;
  EditInputB.Visible := GeometricForm in [gfRectangle];
end;

procedure TMainForm.SetCalculationType(const Value: TCalculationType);
begin
  RadioGroupCalculationType.ItemIndex := Ord(Value);
end;

procedure TMainForm.SetGeometricForm(const Value: TGeometricForm);
begin
  RadioGroupGeometricFigure.ItemIndex := Ord(Value);
end;

procedure TMainForm.SetInputA(const Value: Extended);
begin
  EditInputA.Text := Value.ToString;
end;

procedure TMainForm.SetInputB(const Value: Extended);
begin
  EditInputB.Text := Value.ToString;
end;

procedure TMainForm.SetNumberOutput(const Value: Extended);
begin
  EditOutput.Text := Value.ToString;
end;

procedure TMainForm.SetStringOutput(const Value: string);
begin
  MemoOutput.Lines.Clear;
  MemoOutput.Lines.Add(Value);
end;

procedure TMainForm.ValidateInput;
const
  MaxValue = 9999;
var
  Error: Boolean;
  Message: string;
begin
  Error := False;

  if InputA > MaxValue then
  begin
    Message := Format('O valor do %s deve ser menor ou igual a %d', [EditInputA.EditLabel.Caption, MaxValue]);
    Error := True;
  end;

  if InputB > MaxValue then
  begin
    Message := Format('O valor do %s deve ser menor ou igual a %d', [EditInputB.EditLabel.Caption, MaxValue]);
    Error := True;
  end;

  if not Error then
    Exit;

  MessageDlg(Message, TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
  Abort;
end;

end.

