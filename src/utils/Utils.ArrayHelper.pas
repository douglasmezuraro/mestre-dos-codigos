unit Utils.ArrayHelper;

interface

uses
  System.Generics.Collections;

type
  IArray<T: class> = interface
  ['{560B052B-A3B6-48F8-9169-ED9117A2A9AA}']
    function GetCount: Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    procedure Add(const Element: T);
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    property Count: Integer read GetCount;
    property Item[Index: Integer]: T read GetItem write SetItem;
  end;

  TDynamicArray<T: class> = class(TInterfacedObject, IArray<T>)
  private
    FArray: TArray<T>;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
    function GetCount: Integer;
  public
    procedure Add(const Element: T);
    procedure Remove(const Element: T);
    function IsEmpty: Boolean;
    function Contains(const Element: T): Boolean;
    property Count: Integer read GetCount;
    property Item[Index: Integer]: T read GetItem write SetItem;
  end;

implementation

{ TDynamicArray<T> }

procedure TDynamicArray<T>.Add(const Element: T);
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

function TDynamicArray<T>.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TDynamicArray<T>.Contains(const Element: T): Boolean;
var
  ArrayHelper: TArray;
  FoundIndex: integer;
begin
  Result := ArrayHelper.BinarySearch<T>(FArray, Element, FoundIndex);
end;

function TDynamicArray<T>.GetCount: Integer;
begin
  Result := Length(FArray);
end;

procedure TDynamicArray<T>.Remove(const Element: T);
var
  ArrayHelper: TArray;
  FoundIndex: Integer;
begin
  if ArrayHelper.BinarySearch<T>(FArray, Element, FoundIndex) then
  begin
  end;
end;

procedure TDynamicArray<T>.SetItem(Index: Integer; const Value: T);
begin
  if Index <= Count then
    FArray[Index] := Value;
end;

end.
