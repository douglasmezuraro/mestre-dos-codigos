unit Helper.ZipFile;

interface

uses
  System.Zip;

type
  TZipFileHelper = class Helper for TZipFile
  public
    procedure Add(const AFiles: TArray<string>); overload;
  end;

implementation

procedure TZipFileHelper.Add(const AFiles: TArray<string>);
var
  LFileName: string;
begin
  for LFileName in AFiles do
  begin
    Add(LFileName);
  end;
end;

end.

