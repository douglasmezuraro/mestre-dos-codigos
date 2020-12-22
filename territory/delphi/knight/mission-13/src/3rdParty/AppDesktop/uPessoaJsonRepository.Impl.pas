unit uPessoaJsonRepository.Impl;

interface

uses
  uPessoaRepository, uPessoa, System.IOUtils, System.SysUtils;

type
  TPersonRepository = class sealed(TInterfacedObject, IPessoaRepository)
  private
    function PersonToJson(const APessoa: TPessoa): string;
  public
    function PersistirDados(const APessoa: TPessoa): Boolean;
  end;

implementation

function TPersonRepository.PersistirDados(const APessoa: TPessoa): Boolean;

begin
  Result := True;
  try
    TFile.WriteAllText('Person.json', PersonToJson(APessoa));
  except
    Result := False;
  end;
end;

function TPersonRepository.PersonToJson(const APessoa: TPessoa): string;
var
  LBuilder: TStringBuilder;
begin
  LBuilder := TStringBuilder.Create;
  try
    LBuilder.Append('{')
            .AppendFormat('"ID":"%s",', [APessoa.ID.ToString])
            .AppendFormat('"Nome":"%s",', [APessoa.Nome])
            .AppendFormat('"DataNascimento":"%s",', [DateTimeToStr(APessoa.DataNascimento)])
            .AppendFormat('"EstadoCivil":"%d"', [Ord(APessoa.EstadoCivil)])
            .Append('}');

    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

end.
