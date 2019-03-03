         A instalação do Sistema Processa E.R.P. Open Source é muito fácil,
         bastando para isso seguir alguns passos, conforme será detalhado
         abaixo:


         1) Deve ser feito o download da última versão do Gerenciador de banco
            de dados Firebird 1.5 (disponivel em www.sourceforge.net/projects/firebird)
            ou superior e também do Sistema Processa E.R.P. Open Source
            (disponivel em www.sourceforge.net/projects/processa) para o perfeito
            funcionamento do sistema.
         2) O gerenciador de Banco de Dados deve estar instalado em sua máquina
            local ou uma máquina remota em sua versão Server. Quando o aplicativo
            é executado em uma máquina remota ha também a necessidade da existência
            da instalação cliente do Firebird na máquina que está sendo executado
            o Sistema Processa E.R.P. Open Source.
         3) Feita a instalação , você deve abrir o arquivo processa.ini, que se
            encontra junto com o executável do sistema, e edita a linha que
            contém a variável WinGdb colocando o nome do servidor e o path do
            arquivo .fdb. Por default ele vem da seguinte forma:
            
               WinGdb=c:\sistemas\processa\dados\processa.fdb
               
            Nesta forma o sistema a configuração aponta para acesso local no qual
            está instalado. Para o acesso remoto a linha abaixo deve ser
            configurada conforme segue:
            
               WinGdb=192.168.0.1:c:\sistemas\processa\dados\processa.fdb
               
            O IP (192.168.0.1) que a linha aponta deve ser o ip do servidor.
            O path mostrado no exemplo é para servidores Windows, para servidores
            linux a variável ficaria assim:
            
               WinGdb=192.168.0.1:/usr/local/processa/dados/processa.fdb
               
         4) Para servidores locais a variável Server deve ser nula.
               (ex: Server= )
            Para servidores remotos a variável Server deve conter o nome do
            Servidor ou o numero do IP (Internet Protocol).
               (ex: Server=192.168.0.1)
         5) Para o acesso ao sistema deve ser utilizado o usuário SYSDBA e a
            senha do sysdba no Firebird. Se os dados fornecidos estão corretos
            então o sistema irá carregar abrindo a tela principal do Sistema
            Processa ERP Open Source.
         6) Terminando a carga do aplicativo, deve ser cadastrado os usuarios
            que terão acesso ao sistema, devendo ser feito em módulo
            Gerenciamento do Sistema/Cadastros no programa Cadastro de Acessos.
         7) No programa de Cadastro de Acessos há uma lista com operadores e
            outra lista com sistemas, selecione um Operador e verifique que a
            tela habilita a palheta Operador, assim vc pode inserir um novo
            operador no sistema.
         8) Feito isto é só vc cadastrar agora os acessos para o usuário que
            acabou de criar. Vá na paleta Acessos, e selecione um módulo que
            você quer dar acesso e assinale os programas que você deseja que o
            usuário acesse.
         9) Feche a janela e faça o login com o usuário que criou e bom
            proveito.

         
         Alcindo Schleder
