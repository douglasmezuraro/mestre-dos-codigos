unit Classes.DataBase.Config;

interface

type
  TConfig = class
  private type
    TMonitorBy = (mbNone, mbFlatFile, mbRemote, mbCustom);
    TResultMode = (rmNone, rmStore, rmUse, rmChoose);
    TTinyIntFormat = (tifNone, tifBoolean, tifInt);
  private
    FCompress: Boolean;
    FMonitorBy: TMonitorBy;
    FCharacterSet: string;
    FPooled: Boolean;
    FResultMode: TResultMode;
    FMetaCurCatalog: string;
    FTinyIntFormat: TTinyIntFormat;
    FLoginTimeout: Integer;
    FReadTimeout: Integer;
    FMetaDefCatalog: string;
    FPort: Integer;
    FWriteTimeout: Integer;
    FDatabase: string;
    FDriverID: string;
    FPassword: string;
    FUseSSL: Boolean;
    FUserName: string;
    FServer: string;
    FVendorLib: string;
  public
    { Driver }
    property VendorLib: string read FVendorLib write FVendorLib;
    { Connection }
    property DriverID: string read FDriverID write FDriverID;
    property Pooled: Boolean read FPooled write FPooled default False;
    property Database: string read FDatabase write FDatabase;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property MonitorBy: TMonitorBy read FMonitorBy write FMonitorBy default mbNone;
    property Server: string read FServer write FServer;
    property Port: Integer read FPort write FPort;
    property Compress: Boolean read FCompress write FCompress default True;
    property UseSSL: Boolean read FUseSSL write FUseSSL default False;
    property LoginTimeout: Integer read FLoginTimeout write FLoginTimeout;
    property ReadTimeout: Integer read FReadTimeout write FReadTimeout;
    property WriteTimeout: Integer read FWriteTimeout write FWriteTimeout;
    property ResultMode: TResultMode read FResultMode write FResultMode default rmStore;
    property CharacterSet: string read FCharacterSet write FCharacterSet;
    property TinyIntFormat: TTinyIntFormat read FTinyIntFormat write FTinyIntFormat default tifBoolean;
    property MetaDefCatalog: string read FMetaDefCatalog write FMetaDefCatalog;
    property MetaCurCatalog: string read FMetaCurCatalog write FMetaCurCatalog;
  end;

implementation

end.

