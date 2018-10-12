unit Helpers.CustomControl;

interface

uses
  Vcl.StdCtrls;

type
  TCustomEditHelper = class Helper for TCustomEdit
  public
    function IsEmpty: Boolean;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Mask;

{ TCustomEditHelper }

function TCustomEditHelper.IsEmpty: Boolean;
var
  EditText: string;
begin
  EditText := Self.Text;

  if Self is TMaskEdit then
    EditText := (Self as TMaskEdit).Text;

  Result := EditText.Trim.IsEmpty;
end;

end.
