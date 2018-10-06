unit Utils.Vcl;

interface

uses
  System.Classes,
  System.Math,
  System.StrUtils,
  System.SysUtils,
  Utils.Constants,
  Utils.Date,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Mask,
  Vcl.StdCtrls;

type
  TTagRole = (trUndefined, trMandatory);

  TComponentHelper = class Helper for TComponent
  private
    function GetMandatory: Boolean;
    procedure SetMandatory(const Value: Boolean);
  public
    property Mandatory: Boolean read GetMandatory write SetMandatory;
  end;

  TWinControlHelper = class Helper for TWinControl
  public
    procedure TrySetFocus;
  end;

  TCustomEditHelper = class Helper for TCustomEdit
  public
    function IsEmpty: Boolean;
  end;

  TDateTimePickerHelper = class Helper for TDateTimePicker
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

{ TComponentHelper }

function TComponentHelper.GetMandatory: Boolean;
begin
  Result := Self.Tag = Ord(TTagRole.trMandatory);
end;

procedure TComponentHelper.SetMandatory(const Value: Boolean);
begin
  Self.Tag := IfThen(Value, Ord(TTagRole.trMandatory), Ord(TTagRole.trUndefined));
end;

{ TWinControlHelper }

procedure TWinControlHelper.TrySetFocus;
begin
  if CanFocus then SetFocus;
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
    string(ComponentLabel.Caption).Replace(MANDATORY_CHAR, string.Empty),
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
    ComponentLabel.Caption := Concat(ComponentLabel.Caption, MANDATORY_CHAR);
end;

function TFormHelper.ValidateMandatoryComponents(
  out ComponentLabel: string): Boolean;

  function CustomEdit(Component: TCustomEdit): Boolean;
  begin
    Result := True;
    if Component.IsEmpty then
    begin
      ComponentLabel := GetCaption(Component);
      Result := False;
    end;
  end;

  function DateTimePicker(Component: TDateTimePicker): Boolean;
  begin
    Result := True;
    if Component.IsEmpty then
    begin
      ComponentLabel := GetCaption(Component);
      Result := False;
    end;
  end;

var
  Index: Integer;
begin
  Result := True;
  for Index := 0 to Pred(ComponentCount) do
  begin
    if not Components[Index].Mandatory then
      Continue;

    if Components[Index] is TCustomEdit then
      Result := CustomEdit(Components[Index] as TCustomEdit)
    else if Components[Index] is TDateTimePicker then
      Result := DateTimePicker(Components[Index] as TDateTimePicker);

    if not Result then
    begin
      if Components[Index] is TWinControl then
        (Components[Index] as TWinControl).TrySetFocus;
      Exit;
    end;
  end;
end;

{ TDateTimePickerHelper }

function TDateTimePickerHelper.IsEmpty: Boolean;
begin
  Result := Self.DateTime.IsEmpty;
end;

end.
