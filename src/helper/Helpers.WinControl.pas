unit Helpers.WinControl;

interface

uses
  System.SysUtils,
  Vcl.Controls;

type
  TWinControlHelper = class Helper for TWinControl
  public
    function TrySetFocus: Boolean;
    function IsEmpty: Boolean;
  end;

implementation

uses
  Vcl.Mask;

{ TWinControlHelper }

function TWinControlHelper.IsEmpty: Boolean;
var
  EditText: string;
begin
  EditText := Self.Text;

  if Self is TMaskEdit then
    EditText := (Self as TMaskEdit).Text;

  Result := EditText.Trim.IsEmpty;
end;

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := Self.CanFocus;
  if Result then
    Self.SetFocus;
end;

end.
