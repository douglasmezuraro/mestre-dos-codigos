unit Provider.API;

interface

type
  IProviderAPI = interface
  ['{96C17B38-A6DD-4EE0-9799-938AB5ED51E6}']
    function List: TArray<TObject>;
    function Get(const AId: UInt64): TObject;
  end;

implementation

end.
