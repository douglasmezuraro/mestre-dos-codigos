program MestreDosCodigos;

uses
  Vcl.Forms,
  Collections.API in 'src\collections\Collections.API.pas',
  Collections.DynamicArray in 'src\collections\Collections.DynamicArray.pas',
  Helper.Vcl in 'src\helper\Helper.Vcl.pas',
  Model.Gender in 'src\model\Model.Gender.pas',
  Model.Person in 'src\model\Model.Person.pas',
  Util.Messages in 'src\util\Util.Messages.pas',
  Form.Crud in 'src\form\Form.Crud.pas' {Crud},
  Form.Crud.Person in 'src\form\Form.Crud.Person.pas' {CrudPerson};

{$R *.res}

var
  MainForm: TCrudPerson;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCrudPerson, MainForm);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.

