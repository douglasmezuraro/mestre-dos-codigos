unit Utils.ComponentHelper;

interface

uses
  System.Classes,
  System.Math,
  System.StrUtils,
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Mask,
  Vcl.StdCtrls;

type
  TTagRole = (trUndefined, trMandatory);

  TWinControlHelper = class Helper for TComponent
  private
    function GetMandatory: Boolean;
    procedure SetMandatory(const Value: Boolean);
  public
    property Mandatory: Boolean read GetMandatory write SetMandatory;
  end;

  TCustomEditHelper = class Helper for TCustomEdit
  public
    function IsEmpty: Boolean;
  end;

  TFormHelper = class Helper for TForm
  private
    function GetLabel(Component: TComponent): TCustomLabel;
    function GetCaption(Component: TComponent): string;
    procedure SetMandatoryCaption(Component: TComponent);
  public
    function ValidateMandatoryComponents(out ComponentLabel: string): Boolean;
    procedure SetMandatoryComponents(const Components: TArray<TComponent>);
  end;

implementation

{ TWinControlHelper }

function TWinControlHelper.GetMandatory: Boolean;
begin
  Result := Self.Tag = Ord(TTagRole.trMandatory);
end;

procedure TWinControlHelper.SetMandatory(const Value: Boolean);
begin
  Self.Tag := IfThen(Value, Ord(TTagRole.trMandatory), Ord(TTagRole.trUndefined));
end;

{ TCustomEditHelper }

function TCustomEditHelper.IsEmpty: Boolean;
begin
  if Self is TMaskEdit then
    Result := string((Self as TMaskEdit).Text).Trim.IsEmpty
  else
    Result := string(Text).Trim.IsEmpty;
end;

{ TFormHelper }

function TFormHelper.GetCaption(Component: TComponent): string;
var
  ComponentLabel: TCustomLabel;
begin
  ComponentLabel := GetLabel(Component);
  Result := IfThen(
    Assigned(ComponentLabel),
    ComponentLabel.Caption.Replace('*', ''),
    Component.Name);
end;

function TFormHelper.GetLabel(Component: TComponent): TCustomLabel;
var
  ComponentIndex: Integer;
begin
  Result := nil;
  for ComponentIndex := 0 to Pred(ComponentCount) do
  begin
    if Components[ComponentIndex] is TLabel then
    begin
      if (Components[ComponentIndex] as TLabel).FocusControl = Component then
        Exit(Components[ComponentIndex] as TLabel);
    end
    else if Components[ComponentIndex] is TLabeledEdit then
    begin
      if Components[ComponentIndex] = Component then
        Exit((Components[ComponentIndex] as TLabeledEdit).EditLabel);
    end
  end;
end;

procedure TFormHelper.SetMandatoryComponents(
  const Components: TArray<TComponent>);
var
  Component: TComponent;
begin
  for Component in Components do
  begin
    Component.Mandatory := True;
    SetMandatoryCaption(Component);
  end;
end;

procedure TFormHelper.SetMandatoryCaption(Component: TComponent);
var
  ComponentLabel: TCustomLabel;
begin
  ComponentLabel := GetLabel(Component);
  if Assigned(ComponentLabel) then
    ComponentLabel.Caption := Concat(ComponentLabel.Caption, '*');
end;

function TFormHelper.ValidateMandatoryComponents(
  out ComponentLabel: string): Boolean;
var
  ComponentIndex: Integer;
  Component: TComponent;
begin
  Result := True;
  for ComponentIndex := 0 to Pred(ComponentCount) do
  begin
    Component := Components[ComponentIndex];
    if Component is TCustomEdit then
    begin
      if not (Component as TCustomEdit).Mandatory then
        Continue;

      if (Component as TCustomEdit).IsEmpty then
      begin
        ComponentLabel := GetCaption(Component);
        Exit(False);
      end;
    end;
  end;
end;

end.
