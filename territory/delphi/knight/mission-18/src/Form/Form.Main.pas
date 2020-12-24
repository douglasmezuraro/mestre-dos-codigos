unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit, System.Notification,


  System.Generics.Collections, System.DateUtils, Data.DB, Datasnap.DBClient, Vcl.DBGrids,
  Vcl.AppEvnts;

type
  TMain = class sealed(TForm)
    Timer: TTimer;
    NotificationCenter: TNotificationCenter;
    TrayIcon: TTrayIcon;
    Grid: TDBGrid;
    DataSet: TClientDataSet;
    DataSource: TDataSource;
    FieldDescription: TStringField;
    FieldFireDate: TDateTimeField;
    ApplicationEvents: TApplicationEvents;
    procedure OnTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
  strict private
    FNotifications: TStack<TPair<TDateTime, string>>;
  private
    procedure Mock;
    procedure Minimize;
    procedure Maximize;
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
  FNotifications := TStack<TPair<TDateTime, string>>.Create;
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

procedure TMain.FormCreate(Sender: TObject);
begin
  Mock;
end;

procedure TMain.Maximize;
begin
  TrayIcon.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
  Timer.Enabled := False;
end;

procedure TMain.Minimize;
begin
  Hide;
  WindowState := wsMinimized;
  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  Timer.Enabled := True;
end;

procedure TMain.TrayIconDblClick(Sender: TObject);
begin
  Maximize;
end;

procedure TMain.Mock;
var
  LDate: TDateTime;
  LYear, LMonth, LDay, LHour, LMinute, LSecond: Word;
begin
  LDate := Now;
  LYear := YearOf(LDate);
  LMonth := MonthOf(LDate);
  LDay := DayOf(LDate);
  LHour := HourOf(LDate);
  LMinute := MinuteOf(LDate);
  LSecond := SecondOf(LDate);

  while LSecond < 60 do
  begin
    LDate := EncodeDateTime(LYear, LMonth, LDay, LHour, LMinute, LSecond, 0);
    DataSet.AppendRecord([LDate, 'Test ' + LSecond.ToString]);
    FNotifications.Push(TPair<TDateTime, string>.Create(LDate, 'Test ' + LSecond.ToString));
    Inc(LSecond);
  end;
end;

procedure TMain.OnTimer(Sender: TObject);
const
  DATE_FORMAT: string = 'dd/mm/yyyy hh:MM';
var
  LNotification: TNotification;
  LNow, LTop: string;
begin
  if FNotifications.Count = 0 then
  begin
    Exit;
  end;

  DateTimeToString(LNow, DATE_FORMAT, Now);
  DateTimeToString(LTop, DATE_FORMAT, FNotifications.Peek.Key);

  if not LNow.Equals(LTop) then
  begin
    Exit;
  end;

  LNotification := NotificationCenter.CreateNotification;
  try
    LNotification.Name := Caption;
    LNotification.Title := Caption;
    LNotification.AlertBody := FNotifications.Pop.Value;

    NotificationCenter.PresentNotification(LNotification);
  finally
    LNotification.Free;
  end;
end;

end.

