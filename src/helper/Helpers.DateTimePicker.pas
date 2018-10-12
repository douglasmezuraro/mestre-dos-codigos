unit Helpers.DateTimePicker;

interface

uses
  Vcl.ComCtrls;

type
  TDateTimePickerHelper = class Helper for TDateTimePicker
  public
    function IsEmpty: Boolean;
  end;

implementation

uses
  Helpers.DateTime;

{ TDateTimePickerHelper }

function TDateTimePickerHelper.IsEmpty: Boolean;
begin
  Result := Self.DateTime.IsEmpty;
end;

end.
