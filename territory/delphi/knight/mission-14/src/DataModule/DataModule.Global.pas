unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Script, FireDAC.Comp.ScriptCommands, Vcl.Forms,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TDM = class(TDataModule)
  {$ENDREGION}
  private

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

constructor TDM.Create(AOwner: TComponent);
begin
  inherited;
  ConnectToDatabase;
  SetUp;
end;

procedure TDM.ConnectToDatabase;
begin

end;

procedure TDM.SetUp;
begin

end;

function TDM.DatabaseExists: Boolean;
begin

end;

function TDM.GetDatabasePath: string;
begin

end;

function TDM.GetScripts: TArray<string>;
begin

end;

procedure TDM.RunScripts(Sender: TObject);


end.

