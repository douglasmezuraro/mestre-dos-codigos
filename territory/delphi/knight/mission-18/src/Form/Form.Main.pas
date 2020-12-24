unit Form.Main;

interface

uses
  Data.DB, Datasnap.DBClient, System.Classes, System.Generics.Collections, System.Notification,
  System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.DBGrids, Vcl.AppEvnts, Vcl.DBCtrls,
  Vcl.Grids;

type
  TMain = class sealed(TForm)
  {$REGION 'Visual Components'}
    ApplicationEvents: TApplicationEvents;
    DataSet: TClientDataSet;
    DataSource: TDataSource;
    DBNavigator: TDBNavigator;
    FieldAlertBody: TStringField;
    FieldFireDate: TDateTimeField;
    Grid: TDBGrid;
    NotificationCenter: TNotificationCenter;
    Timer: TTimer;
    TrayIcon: TTrayIcon;
  {$ENDREGION}
    procedure OnTimer(Sender: TObject);
    procedure OnMinimize(Sender: TObject);
    procedure OnTrayIconDblClick(Sender: TObject);
    procedure OnDataSetAfterPost(const ADataSet: TDataSet);
    procedure OnReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
  strict private
    FNotifications: TStack<TNotification>;
  private
    procedure Minimize;
    procedure Maximize;
    function CreateNotification(const ADataSet: TDataSet): TNotification;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
  FNotifications := TStack<TNotification>.Create;
  DataSet.CreateDataSet;
end;

destructor TMain.Destroy;
begin
  while FNotifications.Count > 0 do
  begin
    FNotifications.Pop.Free;
  end;

  FNotifications.Free;
  inherited;
end;

function TMain.CreateNotification(const ADataSet: TDataSet): TNotification;
var
  LNotification: TNotification;
begin
  LNotification := TNotification.Create;
  LNotification.AlertBody := ADataSet.FieldByName('AlertBody').AsString;
  LNotification.FireDate := ADataSet.FieldByName('FireDate').AsDateTime;
  LNotification.Title := Caption;

  Result := LNotification;
end;

procedure TMain.Maximize;
begin
  Timer.Enabled := False;
  TrayIcon.Visible := False;
  WindowState := wsNormal;
  Show;
  Application.BringToFront;
end;

procedure TMain.Minimize;
begin
  Hide;
  WindowState := wsMinimized;
  TrayIcon.Visible := True;
  Timer.Enabled := True;
end;

procedure TMain.OnDataSetAfterPost(const ADataSet: TDataSet);
begin
  FNotifications.Push(CreateNotification(ADataSet));
end;

procedure TMain.OnReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
begin
  Maximize;
end;

procedure TMain.OnMinimize(Sender: TObject);
begin
  Minimize;
end;

procedure TMain.OnTrayIconDblClick(Sender: TObject);
begin
  Maximize;
end;

procedure TMain.OnTimer(Sender: TObject);
const
  DATE_FORMAT: string = 'dd/mm/yyyy hh:MM';
var
  LNow, LFireDate: string;
  LNotification: TNotification;
begin
  if FNotifications.Count = 0 then
  begin
    Exit;
  end;

  DateTimeToString(LNow, DATE_FORMAT, System.SysUtils.Now);
  DateTimeToString(LFireDate, DATE_FORMAT, FNotifications.Peek.FireDate);

  if not LFireDate.Equals(LNow) then
  begin
    Exit;
  end;

  LNotification := FNotifications.Pop;
  try
    NotificationCenter.PresentNotification(LNotification);
  finally
    LNotification.Free;
  end;
end;

end.

