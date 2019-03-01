unit Form.GeometricCalculator;

interface

uses
  GeometricCalculator.API,
  GeometricCalculator.CalculationType,
  GeometricCalculator.GeometricForm,
  System.Actions,
  System.Classes,
  System.SysUtils,
  Util,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Helpers,
  Vcl.StdCtrls;

type
  TGeometricCalculator = class(TForm)
    ActionCalculate: TAction;
    ActionList: TActionList;
    ButtonCalculate: TButton;
    EditInputA: TLabeledEdit;
    EditInputB: TLabeledEdit;
    EditOutput: TLabeledEdit;
    RadioGroupCalculationType: TRadioGroup;
    RadioGroupGeometricFigure: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure ActionCalculateExecute(Sender: TObject);
    procedure RadioGroupGeometricFigureClick(Sender: TObject);
  private
    function Calculate: Extended;
    procedure Initialize;
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
  public
    property GeometricForm: TGeometricForm read GetGeometricForm write SetGeometricForm;
    property CalculationType: TCalculationType read GetCalculationType write SetCalculationType;
    property InputA: Extended read GetInputA write SetInputA;
    property InputB: Extended read GetInputB write SetInputB;
    property Output: Extended read GetOutput write SetOutput;
  end;

implementation

{$R *.dfm}

procedure TGeometricCalculator.ActionCalculateExecute(Sender: TObject);
begin
  Output := Calculate;
end;

function TGeometricCalculator.Calculate: Extended;
begin
  Result := 0;
  case CalculationType of
    ctArea:
      begin
        case GeometricForm of
          gfSquare: Result := SquareArea(InputA) ;
          gfCircle: Result := CircleArea(InputA);
          gfRhombus: Result := RhombusArea(InputA, InputB);
          gfEquilateralTriangle: Result := EquilateralTriangleArea(InputA);
        end;
      end;
    ctPerimeter:
      begin
        case GeometricForm of
          gfSquare: Result := SquarePerimeter(InputA);
          gfCircle: Result := CirclePerimeter(InputA);
          gfRhombus: Result := RhombusPerimeter(InputA, InputB);
          gfEquilateralTriangle: Result := EquilateralTrianglePerimeter(InputA);
        end;
      end;
  end;
end;

procedure TGeometricCalculator.FormShow(Sender: TObject);
begin
  Initialize;
end;

function TGeometricCalculator.GetCalculationType: TCalculationType;
begin
  Result := TCalculationType(RadioGroupCalculationType.ItemIndex);
end;

function TGeometricCalculator.GetGeometricForm: TGeometricForm;
begin
  Result := TGeometricForm(RadioGroupGeometricFigure.ItemIndex);
end;

function TGeometricCalculator.GetInputA: Extended;
begin
  Result := StrToFloatDef(EditInputA.Text, 0);
end;

function TGeometricCalculator.GetInputB: Extended;
begin
  Result := StrToFloatDef(EditInputB.Text, 0);
end;

function TGeometricCalculator.GetOutput: Extended;
begin
  Result := StrToFloatDef(EditOutput.Text, 0);
end;

procedure TGeometricCalculator.Initialize;
begin
  RadioGroupGeometricFigure.Items.AddStrings(TUtil.Methods.ArrayOfToTArray(GeometricFormMap));
  RadioGroupCalculationType.Items.AddStrings(TUtil.Methods.ArrayOfToTArray(CalculationTypeMap));
end;

procedure TGeometricCalculator.RadioGroupGeometricFigureClick(Sender: TObject);
begin
  EditInputA.EditLabel.Caption := GeometricInputCaptionMap[GeometricForm];
  EditInputB.EditLabel.Caption := EditInputA.EditLabel.Caption;
  EditInputB.Visible := GeometricForm in [gfRhombus];
end;

procedure TGeometricCalculator.SetCalculationType(const Value: TCalculationType);
begin
  RadioGroupCalculationType.ItemIndex := Ord(Value);
end;

procedure TGeometricCalculator.SetGeometricForm(const Value: TGeometricForm);
begin
  RadioGroupGeometricFigure.ItemIndex := Ord(Value);
end;

procedure TGeometricCalculator.SetInputA(const Value: Extended);
begin
  EditInputA.Text := Value.ToString;
end;

procedure TGeometricCalculator.SetInputB(const Value: Extended);
begin
  EditInputB.Text := Value.ToString;
end;

procedure TGeometricCalculator.SetOutput(const Value: Extended);
begin
  EditOutput.Text := Value.ToString;
end;

end.

