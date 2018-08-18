unit Utils.ComponentHelper;

interface

uses
  System.Classes,
  System.Math,
  System.SysUtils,
  Vcl.StdCtrls,
  Vcl.Mask;

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

end.
