unit Helpers.WinControl;

interface

uses
  Vcl.Controls;

type
  TWinControlHelper = class Helper for TWinControl
  public
    function TrySetFocus: Boolean;
  end;

implementation

{ TWinControlHelper }

function TWinControlHelper.TrySetFocus: Boolean;
begin
  Result := Self.CanFocus;
  if Result then
    Self.SetFocus;
end;

end.
