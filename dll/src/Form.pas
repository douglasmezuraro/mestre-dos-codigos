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
    function GetGeometricForm: TGeometricForm;
    procedure SetGeometricForm(const Value: TGeometricForm);
    function GetInputA: Extended;
    procedure SetInputA(const Value: Extended);
    function GetInputB: Extended;
    procedure SetInputB(const Value: Extended);
    function GetCalculationType: TCalculationType;
    procedure SetCalculationType(const Value: TCalculationType);
    function GetOutput: Extended;
    procedure SetOutput(const Value: Extended);

    function Calculate: Extended;
    procedure Initialize;
    function ArrayOfToTArray<T>(const Values: array of T): TArray<T>;

    function Foo: string;
  public
    property GeometricForm: TGeometricForm read GetGeometricForm write SetGeometricForm;
    property CalculationType: TCalculationType read GetCalculationType write SetCalculationType;
    property InputA: Extended read GetInputA write SetInputA;
    property InputB: Extended read GetInputB write SetInputB;
    property Output: Extended read GetOutput write SetOutput;
  end;

implementation

{$R *.dfm}

procedure TMainForm.ActionCalculateExecute(Sender: TObject);
begin
  Output := Calculate;
  MemoOutput.Clear;
  MemoOutput.Lines.Add(Foo);
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

function TMainForm.Foo: string;
var
  ExtensiveNumber: TExtensiveNumber;
begin
  ExtensiveNumber := TExtensiveNumber.Create(Output);
  try
    Result := ExtensiveNumber.Make();
  finally
    ExtensiveNumber.Free;
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

function TMainForm.GetOutput: Extended;
begin
  Result := StrToFloatDef(EditOutput.Text, 0);
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

procedure TMainForm.SetOutput(const Value: Extended);
begin
  EditOutput.Text := Value.ToString;
end;

end.

