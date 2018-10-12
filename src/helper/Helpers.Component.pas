unit Helpers.Component;

interface

uses
  System.Classes,
  Utils.TagRole;

type
  TComponentHelper = class Helper for TComponent
  private
    function GetMandatory: Boolean;
    procedure SetMandatory(const Value: Boolean);
  public
    property Mandatory: Boolean read GetMandatory write SetMandatory;
  end;

implementation

{ TComponentHelper }

function TComponentHelper.GetMandatory: Boolean;
begin
  Result := Self.Tag = Ord(TTagRole.trMandatory);
end;

procedure TComponentHelper.SetMandatory(const Value: Boolean);
begin
  Self.Tag := Ord(TTagRole.trUndefined);
  if Value then
    Self.Tag := Ord(TTagRole.trMandatory);
end;

end.
