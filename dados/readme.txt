         A instala��o do Sistema Processa E.R.P. Open Source � muito f�cil,
         bastando para isso seguir alguns passos, conforme ser� detalhado
         abaixo:


         1) Deve ser feito o download da �ltima vers�o do Gerenciador de banco
            de dados Firebird 1.5 (disponivel em www.sourceforge.net/projects/firebird)
            ou superior e tamb�m do Sistema Processa E.R.P. Open Source
            (disponivel em www.sourceforge.net/projects/processa) para o perfeito
            funcionamento do sistema.
         2) O gerenciador de Banco de Dados deve estar instalado em sua m�quina
            local ou uma m�quina remota em sua vers�o Server. Quando o aplicativo
            � executado em uma m�quina remota ha tamb�m a necessidade da exist�ncia
            da instala��o cliente do Firebird na m�quina que est� sendo executado
            o Sistema Processa E.R.P. Open Source.
         3) Feita a instala��o , voc� deve abrir o arquivo processa.ini, que se
            encontra junto com o execut�vel do sistema, e edita a linha que
            cont�m a vari�vel WinGdb colocando o nome do servidor e o path do
            arquivo .fdb. Por default ele vem da seguinte forma:
            
               WinGdb=c:\sistemas\processa\dados\processa.fdb
               
            Nesta forma o sistema a configura��o aponta para acesso local no qual
            est� instalado. Para o acesso remoto a linha abaixo deve ser
            configurada conforme segue:
            
               WinGdb=192.168.0.1:c:\sistemas\processa\dados\processa.fdb
               
            O IP (192.168.0.1) que a linha aponta deve ser o ip do servidor.
            O path mostrado no exemplo � para servidores Windows, para servidores
            linux a vari�vel ficaria assim:
            
               WinGdb=192.168.0.1:/usr/local/processa/dados/processa.fdb
               
         4) Para servidores locais a vari�vel Server deve ser nula.
               (ex: Server= )
            Para servidores remotos a vari�vel Server deve conter o nome do
            Servidor ou o numero do IP (Internet Protocol).
               (ex: Server=192.168.0.1)
         5) Para o acesso ao sistema deve ser utilizado o usu�rio SYSDBA e a
            senha do sysdba no Firebird. Se os dados fornecidos est�o corretos
            ent�o o sistema ir� carregar abrindo a tela principal do Sistema
            Processa ERP Open Source.
         6) Terminando a carga do aplicativo, deve ser cadastrado os usuarios
            que ter�o acesso ao sistema, devendo ser feito em m�dulo
            Gerenciamento do Sistema/Cadastros no programa Cadastro de Acessos.
         7) No programa de Cadastro de Acessos h� uma lista com operadores e
            outra lista com sistemas, selecione um Operador e verifique que a
            tela habilita a palheta Operador, assim vc pode inserir um novo
            operador no sistema.
         8) Feito isto � s� vc cadastrar agora os acessos para o usu�rio que
            acabou de criar. V� na paleta Acessos, e selecione um m�dulo que
            voc� quer dar acesso e assinale os programas que voc� deseja que o
            usu�rio acesse.
         9) Feche a janela e fa�a o login com o usu�rio que criou e bom
            proveito.

         
         Alcindo Schleder
