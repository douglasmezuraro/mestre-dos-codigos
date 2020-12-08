program Mission09;

//       Author : Douglas Mezuraro
// Modification : 08/12/2020
//        Level : Knight
//      Mission : 09
//    Objective : Fa�a o download e instala��o do framework Horse (https://github.com/HashLoad/horse)
//                para criar uma API no Delphi. Essa API dever� exportar duas rotas:
//                  - /estados: retorna uma lista com o nome de todos os estados do Brasil;
//                  - /estado/{id}: retorna o nome, sigla, regi�o e capital do estado referente ao ID informado.
//                Use a p�gina do Wikipedia para definir os IDs:
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
