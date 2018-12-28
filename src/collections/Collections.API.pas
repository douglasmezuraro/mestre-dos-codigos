unit Collections.API;

interface

type
  ICollection<T: class> = interface
  ['{560B052B-A3B6-48F8-9169-ED9117A2A9AA}']
    { getters and setter methods }
    function GetCount: Integer;
    function GetItem(const Index: Integer): T;
    procedure SetItem(const Index: Integer; const Value: T);
    { methods }
    function Add(const Element: T): Integer;
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    function IndexOf(const Element: T): Integer;
    function InRange(const Index: Integer): Boolean;
    function ToArray: TArray<T>;
    { properties }
    property Count: Integer read GetCount;
    property Item[const Index: Integer]: T read GetItem write SetItem;
  end;

implementation

end.
