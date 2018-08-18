unit Vcl.Helpers;

interface

uses
  System.Classes, System.Math;

type
  TTagRole = (trUndefined, trMandatory);

  TWinControlHelper = class Helper for TComponent
  private
    function GetMandatory: Boolean;
    procedure SetMandatory(const Value: Boolean);
  public
    property Mandatory: Boolean read GetMandatory write SetMandatory;
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

end.
