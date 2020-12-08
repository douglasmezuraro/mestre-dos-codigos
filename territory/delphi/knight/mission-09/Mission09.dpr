program Mission09;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 09
//    Objective : Faça o download e instalação do framework Horse (https://github.com/HashLoad/horse)
//                para criar uma API no Delphi. Essa API deverá exportar duas rotas:
//                  - /estados: retorna uma lista com o nome de todos os estados do Brasil;
//                  - /estado/{id}: retorna o nome, sigla, região e capital do estado referente ao ID informado.
//                Use a página do Wikipedia para definir os IDs:
//                https://pt.wikipedia.org/wiki/Unidades_federativas_do_Brasil

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on Error: Exception do
    begin
      Writeln(Error.ClassName, ': ', Error.Message);
    end;
  end;
end.
