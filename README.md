# Delphi

## Cavaleiro

1. Em uma aplicação console, defina duas Interfaces, chamadas `IRepositorioNuvem` e `IRepositorioArquivo`. Ambas devem declarar o método "SalvarDados". Em seguida, declare uma classe que implemente as duas Interfaces e codifique o método "SalvarDados" de cada Interface. Use o conceito de _**Method Resolution Clause**_ para tratar o conflito de nomes de métodos iguais.

2. Desenvolva uma aplicação VCL capaz de listar os programas instalados no computador através da leitura do registro do Windows. Para isso, utilize a classe `TRegistry` e apresente, em uma `TDBGrid`, o nome do programa, versão e a empresa.

3. Desenvolva uma aplicação VCL que faça a compactação de arquivos utilizando a classe  **`TZipFile`**. Para isso, no formulário principal, permita que o usuário possa selecionar os arquivos que deseja compactar, bem como o caminho e nome do arquivo compactado que será criado. A operação deve observar as seguintes regras e comportamentos: Arquivos com extensão .EXE não podem ser selecionados (exiba uma mensagem ao usuário);
-   Caso o arquivo que será criado já exista, deve ser sobrescrito sem confirmação;
-   O progresso da compactação deve ser exibido em uma barra de progresso.

4. Em uma aplicação VCL, declare uma _**array**_  **de Tasks** de 3 posições. Cada posição deste _array_ deverá realizar a leitura de um diretório informado pelo usuário e listar todos os arquivos em um componente `TMemo`. Portanto, a aplicação deverá ter 3 componentes `TMemo` e 3 componentes `TEdit` para que o usuário informe os diretórios. Durante a leitura dos diretórios, a aplicação não poderá ficar travada, já que as Tasks deverão ser executadas paralelamente. Para testar a aplicação, informe diretórios com grandes quantidades de arquivos, como a pasta do Windows ou do Microsoft Office.

5. Em uma aplicação console ou VCL, faça um laço de repetição de 1 até 1 milhão listando os números primos encontrados, utilizando o _**TParallel**_ da biblioteca `System.Threading` para paralelizar as iterações.

6. Em uma aplicação VCL, declare uma **classe**  _**Thread**_ responsável por fazer o download de um arquivo qualquer da internet. Em seguida, em um formulário, adicione um campo de texto para que o usuário informe o endereço do arquivo, e uma barra de progresso para exibir o progresso do download. A classe `TThread` deverá ser utilizada para baixar o arquivo e atualizar a barra de progresso sem travar a aplicação.

7. Neste exercício, você deverá criar uma aplicação VCL para envio de e-mails utilizando o  **Indy**. O formulário deverá disponibilizar campos de texto para informar o endereço SMTP, usuário, senha, porta e configurações de SSL. Além disso, adicione também um campo para informar o anexo e um componente  `TMemo`  para informar o corpo da mensagem, no qual poderá aceitar comandos HTML. Faça a chamada do envio do e-mail em uma  **Anonymous Thread**.

8. Em uma aplicação VCL, você deverá criar um formulário que permita a pesquisa de usuários do GitHub. Para isso, utilize os componentes da paleta **REST Client** para acessar a API pública do GitHub ([https://api.github.com/users/{busca}](https://api.github.com/users/%7Bbusca%7D)), substituindo o texto "{busca}" pela entrada do usuário. Utilize o componente `TRestResponseDataSetAdapter` para apresentar os resultados em um componente `TDBGrid`.

9. Faça o download e instalação do framework  **Horse**  ([https://github.com/HashLoad/horse](https://github.com/HashLoad/horse)) para criar uma API no Delphi. Essa API deverá exportar duas rotas:
-   /estados: retorna uma lista com o nome de todos os estados do Brasil;
-   /estado/{id}: retorna o nome, sigla, região e capital do estado referente ao ID informado. Use a página do Wikipedia para definir os IDs:  [https://pt.wikipedia.org/wiki/Unidades_federativas_do_Brasil](https://pt.wikipedia.org/wiki/Unidades_federativas_do_Brasil).

10. Em uma aplicação VCL, faça a importação do WSDL do site RegExLib ([http://regexlib.com/WebServices.asmx?WSDL](http://regexlib.com/WebServices.asmx?WSDL)). Este WebService contém um catálogo de expressões regulares para serem utilizadas. Faça um acesso ao WebService e consulte a expressão regular **nº 3122**, referente a validação de e-mails. Em seguida, utilize essa expressão para validar um endereço de e-mail informado pelo usuário, apresentando o texto "e-mail válido" ou "e-mail inválido" conforme o resultado.

11. Crie uma aplicação VCL que permita a consulta dos dados de endereço através do CEP. Para isso, importe o WSDL dos Correios ([https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl](https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl)). No formulário, adicione um campo de texto para informar o CEP e apresente os dados do endereço (logradouro, bairro, cidade e UF).

12. Em uma aplicação console, defina uma classe chamada  `TOperacoes`  que contenha os seguintes métodos:
- `OrdenarLetras`: receba uma palavra como parâmetro e retorne um texto com as letras ordenadas em ordem alfabética, sem espaços;
- `ContarOcorrencias`: receba dois parâmetros (uma palavra e uma letra), e conte a quantidade de ocorrências que a letra é encontrada na palavra, retornando um número. Caso a palavra ou a letra estejam vazios, levante uma exceção;
 - `RemoverAcentos`: receba uma palavra como parâmetro e remova todos os acentos (por exemplo: "órgão" para "orgao"). Caso exista algum caracter que não seja alfanumérico, uma exceção deve ser gerada.
Em seguida, implemente  **testes unitários**  para essa classe, testando inclusive as exceções.

13. Sistemas, para serem testáveis, precisam possuir baixo acoplamento. Assim, durante a etapa de testes, é possível, por exemplo, substituir a camada de persistência de dados por um mock que “fará de conta” que os dados foram salvos com sucesso. Ou ainda, emitir uma exceção simulando um erro na camada de infraestrutura. Para construção de mocks e stubs, existe uma biblioteca gratuita chamada  **Delphi-Mocks**  ([https://github.com/VSoftTechnologies/Delphi-Mocks](https://github.com/VSoftTechnologies/Delphi-Mocks)). Utilizando a biblioteca  **Delphi-Mocks**, escreva os teste unitários para a classe  `TPessoaService`. Utilize o framework  **Delphi-Mocks**  para mockar o repositório. Não serão aceitos códigos implementados com classes fake. Os testes devem incluir:
- O comportamento de quando  **TPessoa**  está inválido;
- Garantir que o método de  **TPessoaRepository**  não será chamado quando  **TPessoa**  não estiver válida;
- Garantir que o método de  **TPessoaRepository**  será chamado quando  **TPessoa**  estiver válido;
- O comportamento de  `TPessoaService`  quando  **TPessoaRepository**  emite uma exceção  `EDatabaseError`;
- O comportamento de  `TPessoaService`, caso  **TPessoaRepository**  emita qualquer outra exceção que não seja  `EDatabaseError`;
O código para esta resolução está disponível  [aqui](https://github.com/db1global/mestre-dos-codigos/tree/master/docs/files/cavaleiro-delphi/projeto).

14.  Crie um banco de dados no Firebird 3.0 com as seguintes tabelas e campos:
    -   FUNCIONARIO
        -   ID
        -   Nome
        -   Data de Admissão
        -   Salário
    -   DEPARTAMENTO
        -   ID
        -   Descricao
        -   Telefone
    -   FUNCIONARIO_DEPARTAMENTO
        -   IDFuncionario
        -   IDDepartamento

Crie uma alicação VCL que permita cadastrar funcionários, departamentos e vincular funcionários a departamentos (mestre-detalhe). A conexão com o banco de dados e a manipulação de dados devem ser feitas com  **FireDAC**.

15. O componente `TFDLocalSql` é utilizado para executar comandos SQLs em DataSets em memória, ou seja, sem conexão com bancos de dados. Neste exercício, baixe os arquivos **Clientes.xml** e **Cidades.xml** ([disponíveis aqui](https://github.com/db1global/mestre-dos-codigos/tree/master/docs/files/cavaleiro-delphi/dados)). Em uma aplicação VCL, carregue estes arquivos em dois componentes `TFDMemTable`. Em seguida, use o componente `TFDLocalSql` para ligar os dados dos dois componentes (pelo campo IdCidade) de forma que, em uma `TDBGrid`, sejam exibidos o nome do cliente e o nome da cidade. A aplicação também deve permitir que o usuário filtre os clientes de uma cidade específica.

16. Na aplicação do exercício 13, a unit `uPessoa` está emitindo um warning. Sem alterar o código da classe, faça com que o warning não seja mais emitido e adicione um comentário explicando o que o causava e de qual forma o código poderia ser reescrito para que ele não fosse emitido.

17. Na aplicação do exercício 13, a classe `TfrmSalvadorDePessoas` possui o método `PegarPessoaService`, que devolve o serviço criado e com o repositório já injetado. Crie uma nova classe que implemente `IPessoaRepository`, dando-lhe o nome que preferir. Implemente o método `PersistirDados` de modo que os dados sempre sejam salvos. Uma vez que a classe tenha sido escrita, utilizando **Diretivas de compilação**, altere o fluxo do sistema. Quando o sistema estiver compilando com a diretiva `PERSISTENCIA_PADRAO`, o sistema utilizará a versão do repository original. Do contrário, o sistema utilizará a persistência escrita por você.

18. Crie uma aplicação VCL que funcione como um “notificador de lembretes”. O usuário poderá informar a data (dd/mm/yyyy), horário (hh:mm) e descrição de quantos lembretes desejar. Ao minimizar, a aplicação deverá ficar na bandeja do sistema (system tray). Utilize um `TTimer` para comparar a data/hora atual com o lembrete e, quando for o horário correspondente, exiba uma notificação no Windows com o componente `TNotificationCenter`. Ao clicar na notificação, a aplicação deverá ser restaurada e exibida para o usuário.

19. Crie um banco de dados no Firebird 3.0 com a seguinte tabela:
    -   FUNCIONARIO
        -   ID (inteiro)
        -   Nome (texto)
        -   Cidade (texto)
        -   Email (texto)
        -   DataNasc (data)
        -   Profissao (texto)
        -   Cartao (texto )

Desenvolva uma aplicação VCL que carregue o arquivo  **Dados.csv**  e faça a inserção dos 20 mil registros nessa tabela usando o recurso  **ArrayDML**  do  **FireDAC**. Calcule o tempo de inserção utilizando a classe  `TStopWatch`  e exiba-o em uma mensagem após a conclusão da operação.