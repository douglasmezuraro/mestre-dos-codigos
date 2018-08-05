unit Utils.DynamicArrayInterface;

interface

type
  IDynamicArray<T: class> = interface
  ['{560B052B-A3B6-48F8-9169-ED9117A2A9AA}']
    function GetCount: Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    procedure Insert(const Element: T);
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    function IndexOf(const Element: T): Integer;
    property Count: Integer read GetCount;
    property Item[Index: Integer]: T read GetItem write SetItem;
  end;

implementation

end.
