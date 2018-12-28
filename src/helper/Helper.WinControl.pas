unit Helper.WinControl;

interface

uses
  System.SysUtils,
  Vcl.Controls,
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

end.

