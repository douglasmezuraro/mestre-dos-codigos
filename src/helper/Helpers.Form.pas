unit Helpers.Form;

interface

uses
  System.Classes,
  System.SysUtils,
  Utils.Constants,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TFormHelper = class Helper for TForm
  private
    function GetLabel(Component: TWinControl): TCustomLabel;
    function GetCaption(Component: TWinControl): string;
    procedure SetMandatoryCaption(Component: TWinControl);
  public
    function ValidateMandatoryComponents(out ComponentLabel: string): Boolean;
    procedure SetMandatoryComponents(const Components: TArray<TWinControl>);
  end;

implementation

uses
  Helpers.WinControl;

{ TFormHelper }

function TFormHelper.GetCaption(Component: TWinControl): string;
var
  ComponentLabel: TCustomLabel;
  Caption: string;
begin
  Caption := Component.Name;

  ComponentLabel := GetLabel(Component);
  if Assigned(ComponentLabel) then
  begin
    Caption := ComponentLabel.Caption;
    Caption.Replace(MANDATORY_CHAR, Caption.Empty);
  end;

  Result := Caption;
end;

function TFormHelper.GetLabel(Component: TWinControl): TCustomLabel;
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
  const Components: TArray<TWinControl>);
var
  Component: TWinControl;
begin
  for Component in Components do
  begin
    Component.Mandatory := True;
    SetMandatoryCaption(Component);
  end;
end;

procedure TFormHelper.SetMandatoryCaption(Component: TWinControl);
var
  ComponentLabel: TCustomLabel;
begin
  ComponentLabel := GetLabel(Component);
  if Assigned(ComponentLabel) then
    ComponentLabel.Caption := Concat(ComponentLabel.Caption, MANDATORY_CHAR);
end;

function TFormHelper.ValidateMandatoryComponents(
  out ComponentLabel: string): Boolean;
var
  Index: Integer;
  Component: TWinControl;
begin
  Result := True;
  for Index := 0 to Pred(ComponentCount) do
  begin
    if not (Components[Index] is TWinControl) then
      Continue;

    Component := Components[Index] as TWinControl;

    if not Component.Mandatory then
      Continue;

    if Component is TCustomEdit then
      Result := not (Component as TCustomEdit).IsEmpty
    else if Component is TDateTimePicker then
      Result := not (Component as TDateTimePicker).IsEmpty;

    if not Result then
    begin
      ComponentLabel := GetCaption(Component);
      ComponentLabel := ComponentLabel.Replace(MANDATORY_CHAR, string.Empty);

      if Component is TWinControl then
        (Component as TWinControl).TrySetFocus;

      Break;
    end;
  end;
end;

end.
