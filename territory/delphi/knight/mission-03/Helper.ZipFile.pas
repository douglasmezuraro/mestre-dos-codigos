unit Helper.ZipFile;

interface

uses
  System.Zip;

type
  TZipFileHelper = class Helper for TZipFile
  public
    procedure Add(const Files: TArray<string>); overload;
  end;

implementation

procedure TZipFileHelper.Add(const Files: TArray<string>);
var
  FileName: string;
begin
  for FileName in Files do
  begin
    Add(FileName);
  end;
end;

end.
