unit Utils.DynamicArray;

interface

uses
  System.Math,
  System.SysUtils,
  System.Generics.Collections,
  Utils.DynamicArrayInterface;

type
  TDynamicArray<T: class> = class(TInterfacedObject, IDynamicArray<T>)
  private
    FArray: TArray<T>;
    FOwnsObjects: Boolean;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    function GetCount: Integer;
  public
    constructor Create(const OwnsObjects: Boolean = True);
    destructor Destroy; override;
    procedure Insert(const Element: T);
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    function IndexOf(const Element: T): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: T read GetItem write SetItem;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;

implementation

{ TDynamicArray<T> }

procedure TDynamicArray<T>.Insert(const Element: T);
begin
  SetLength(FArray, Succ(Count));
  FArray[Pred(Count)] := Element;
end;

function TDynamicArray<T>.GetItem(Index: Integer): T;
begin
  Result := nil;
  if not Self.IsEmpty then
    Result := FArray[Index];
end;

function TDynamicArray<T>.IndexOf(const Element: T): Integer;
var
  Values: TArray;
  FoundIndex: Integer;
begin
  Result := NegativeValue;
  if Values.BinarySearch<T>(FArray, Element, FoundIndex) then
    Result := FoundIndex;
end;

function TDynamicArray<T>.IsEmpty: Boolean;
begin
  Result := Count = ZeroValue;
end;

function TDynamicArray<T>.Contains(const Element: T): Boolean;
begin
  Result := IndexOf(Element) <> NegativeValue;
end;

constructor TDynamicArray<T>.Create(const OwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := OwnsObjects;
end;

destructor TDynamicArray<T>.Destroy;
var
  Element: T;
begin
  if OwnsObjects then
    for Element in FArray do
      Element.Free;

  inherited Destroy;
end;

function TDynamicArray<T>.GetCount: Integer;
begin
  Result := Length(FArray);
end;

procedure TDynamicArray<T>.Remove(const Element: T);
var
  Index: Integer;
begin
  Index := IndexOf(Element);
  if Index <> NegativeValue then
    FreeAndNil(FArray[Index]);
end;

procedure TDynamicArray<T>.SetItem(Index: Integer; const Value: T);
begin
  FArray[Index] := Value;
end;

end.

