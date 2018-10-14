unit Helpers.WinControl;

interface

uses
  System.SysUtils,
  Vcl.Controls;

type
  TWinControlHelper = class Helper for TWinControl
  private type
    TTagRole = (trUndefined, trMandatory);
  private
    function GetMandatory: Boolean;
    procedure SetMandatory(const Value: Boolean);
  public
    function TrySetFocus: Boolean;
    function IsEmpty: Boolean;
    property Mandatory: Boolean read GetMandatory write SetMandatory;
  end;

implementation

uses
  Vcl.Mask,
  Utils.Constants;

{ TWinControlHelper }

function TWinControlHelper.GetMandatory: Boolean;
begin
  Result := TTagRole(Self.Tag) = trMandatory;
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

procedure TWinControlHelper.SetMandatory(const Value: Boolean);
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
