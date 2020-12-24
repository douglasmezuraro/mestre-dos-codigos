unit Form.Main;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, System.Notification,


  System.Generics.Collections, Data.DB, Datasnap.DBClient, Vcl.DBGrids,
  Vcl.AppEvnts, Vcl.DBCtrls, Vcl.Grids;

type
  TMain = class sealed(TForm)
    Timer: TTimer;
    NotificationCenter: TNotificationCenter;
    TrayIcon: TTrayIcon;
    Grid: TDBGrid;
    DataSet: TClientDataSet;
    DataSource: TDataSource;
    FieldFireDate: TDateTimeField;
    ApplicationEvents: TApplicationEvents;
    FieldAlertBody: TStringField;
    dbnvgr1: TDBNavigator;
    procedure OnTimer(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure DataSetAfterPost(ADataSet: TDataSet);
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
  FNotifications.Free;
  inherited;
end;

procedure TMain.ApplicationEventsMinimize(Sender: TObject);
begin
  Minimize;
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

procedure TMain.DataSetAfterPost(ADataSet: TDataSet);
begin
  FNotifications.Push(CreateNotification(ADataSet));
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

procedure TMain.TrayIconDblClick(Sender: TObject);
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

  DateTimeToString(LNow, DATE_FORMAT, Now);
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

