unit Helpers.WinControl;

interface

uses
  System.SysUtils,
  Vcl.Controls;

type
  TWinControlHelper = class Helper for TWinControl
  private type
    TTagRole = (trUndefined, trRequired);
  private
    function GetRequired: Boolean;
    procedure SetRequired(const Value: Boolean);
  public
    function TrySetFocus: Boolean;
    function IsEmpty: Boolean;
    property Required: Boolean read GetRequired write SetRequired;
  end;

implementation

uses
  Vcl.Mask,
  Utils.Constants;

{ TWinControlHelper }

function TWinControlHelper.GetRequired: Boolean;
begin
  Result := TTagRole(Self.Tag) = trRequired;
end;

function TWinControlHelper.IsEmpty: Boolean;
var
  EditText: string;
begin
  EditText := Self.Text;

  if Self is TMaskEdit then
    EditText := (Self as TMaskEdit).Text;

  Result := EditText.Trim.IsEmpty;
end;

procedure TWinControlHelper.SetRequired(const Value: Boolean);
begin
  Self.Tag := Value.ToInteger;
end;

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := Self.CanFocus;
  if Result then
    Self.SetFocus;
end;

end.
