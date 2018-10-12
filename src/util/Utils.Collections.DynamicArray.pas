unit Utils.Collections.DynamicArray;

interface

uses
  System.Math,
  System.SysUtils,
  System.Generics.Collections,
  Utils.Collections.API;

type
  TDynamicArray<T: class> = class(TInterfacedObject, ICollection<T>)
  private
    FArray: TArray<T>;
    FOwnsObjects: Boolean;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    function GetCount: Integer;
  public
    constructor Create(const OwnsObjects: Boolean = True);
    destructor Destroy; override;
    function Add(const Element: T): Integer;
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    function IndexOf(const Element: T): Integer;
    function InRange(const Index: Integer): Boolean;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: T read GetItem write SetItem;
  end;

implementation

{ TDynamicArray<T> }

function TDynamicArray<T>.Add(const Element: T): Integer;
begin
  Result := Count;
  SetLength(FArray, Succ(Count));
  FArray[Result] := Element;
end;

function TDynamicArray<T>.GetItem(Index: Integer): T;
begin
  Result := nil;
  if InRange(Index) then
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

function TDynamicArray<T>.InRange(const Index: Integer): Boolean;
begin
  Result := Index <= Pred(Count);
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
  if FOwnsObjects then
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

