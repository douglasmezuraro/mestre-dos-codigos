unit Vcl.Helpers;

interface

uses
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Mask;

type
  TWinControlHelper = class Helper for TWinControl
  private type
    TTagRole = (trUndefined, trRequired);
  private
    function GetRequired: Boolean;
    procedure SetRequired(const Value: Boolean);
  public
    const RequiredChar: Char = '*';
    function TrySetFocus: Boolean;
    function IsEmpty: Boolean;
    function ToString: string;
    property Required: Boolean read GetRequired write SetRequired;
  end;

  TCustomRadioGroupHelper = class Helper for TCustomRadioGroup
  public
    procedure AddValues(const Values: array of string);
  end;

implementation

{ TWinControlHelper }

function TWinControlHelper.GetRequired: Boolean;
begin
  Result := Tag = Ord(trRequired);
end;

function TWinControlHelper.IsEmpty: Boolean;
begin
  Result := ToString.Trim.IsEmpty;
end;

procedure TWinControlHelper.SetRequired(const Value: Boolean);
begin
  Tag := Value.ToInteger;
end;

function TWinControlHelper.ToString: string;
var
  Text: string;
begin
  Text := Self.Text;

  if Self is TMaskEdit then
    Text := (Self as TMaskEdit).Text;

  Result := Text;
end;

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := CanFocus;
  if Result then
    SetFocus;
end;

{ TCustomRadioGroupHelper }

procedure TCustomRadioGroupHelper.AddValues(const Values: array of string);
var
  Value: string;
begin
  Items.Clear;
  for Value in Values do
    Items.Add(Value);

  if Items.Count > 0 then
    ItemIndex := 0;
end;

end.

