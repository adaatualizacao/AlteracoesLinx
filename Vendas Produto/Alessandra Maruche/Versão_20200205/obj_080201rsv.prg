* Criação *********************************************************************************************************** 
* PROGRAMADOR(A).: MARCELO FABIANO                                                                                  *
* DATA...........: 14/08/2014                                                                                       *
* HORÁRIO........: 14:49                                                                                            *
********************************************************************************************************************* 
* CLIENTE..: CD                                                                                                     *
* OBJETIVO.: BLOQUEAR A EXCLUSÃO DE PEDIDOS COM ITENS EM RESERVA                                                    *
********************************************************************************************************************* 

* Alteração ********************************************************************************************************* 
* PROGRAMADOR(A).:                                                                                                  *
* DATA...........:                                                                                                  *
* HORÁRIO........:                                                                                                  *
********************************************************************************************************************* 
* CLIENTE..:                                                                                                        *
* OBJETIVO.:                                                                                                        *
********************************************************************************************************************* 


********************************************************************************************************************* 
*- Programa Base de Criação de Objeto de Entrada                                                                    *
********************************************************************************************************************* 
*- O programa deve ser texto com o nome = OBJ_xxxxxx.prg onde x=numero da tela                                      *
*- Este arquivo deve ser colocado no diretorio \Linx_sql\Linx\Exclusivos                                            *
********************************************************************************************************************* 
*- Existem 2 parametros que influem nos objetos de Entrada:                                                         *
*  utiliza_objeto_entrada = .f. desliga os objetos de entrada para testar telas sem os mesmos                       *
*  mostra_nome_obj = .t. mostra o nome dos objetos no tooltip em tempo de execução para facilitar o desenvolvimento *
********************************************************************************************************************* 
* - Atencao !!!!!!!!!!!														                                        *
* - Toda vez que houver qualquer alteracao no PRG deve-se apagar o arquivo FXP                                      *
********************************************************************************************************************* 

define class obj_entrada as custom
	*- Nome do metodo/função que os objetos linx vão chamar.

	procedure metodo_usuario
		*- Parametros do metodo:
		*- Xmetodo= nome do metodo
		*- Xobjeto= variavel com a referencia ao objeto
		*- Xnome_obj  = nome do objeto
		lparam xmetodo, xobjeto, xnome_obj
		
		******************** Metodos chamados pelo FORMSET
		*	USR_INIT  												=> NA INICIALIZACAO DA TELA 
		*	USR_ALTER_BEFORE  -> Return .f. Para o Metodo 			=> ANTES DA ALTERACAO ,AO CLICKAR ANTES DE LIBERAR OS CAMPOS
		*	USR_ALTER_AFTER 										=> APOS LIBERAR OS CAMPOS PARA INCLUSAO   
		*	USR_INCLUDE_AFTER 										=> APOS LIBERAR OS CAMPOS PARA INCLUSAO
		*	USR_SEARCH_BEFORE -> Return .f. Para o Metodo PESQUISA	=> ANTES DE FAZER A PESQUISA NO BANCO
		*	USR_SEARCH_AFTER										=> APOS FAZER A PESQUISA NO BANCO
		*	USR_CLEAN_AFTER 										=> APOS LIMPAR A TELA 
		*	USR_REFRESH                                             => 
		*	USR_SAVE_BEFORE   -> Return .f. Para o Metodo 			=> SALVAR ANTES DE JOGAR INFORMACOES NO BANCO
		*	USR_SAVE_AFTER                                          => APOS SALVAR AS INFORMACOES    NO BANCO
		*	USR_ITEN_DELETE_BEFORE -> Return .f. Para o Metodo 		=> ANTES DE EXCLUIR ITEN NA TABELA FILHA '+'
		*	USR_ITEN_DELETE_AFTER                                   => APOS DELETAR UM ITEM NA TABELA FILHA '-' 
		*	USR_ITEN_INCLUDE_BEFORE -> Return .f. Para o Metodo 	=> ANTES DE INCLUIR ITEM NA TABELA FILHA
		*	USR_ITEN_INCLUDE_AFTER									=> APOS INCLUIR ITEM NA TABELA FILHA 
		*
		***************** Metodos que ocorrem dentro da Transaction do Banco de Dados
		*	USR_TRIGGER_AFTER ->Return .f. Para o Salvamento e da Rollback ANTES DE EXECUTAR UMA TRIGGER
		*	USR_TRIGGER_BEFORE ->Return .f. Para o Salvamento e da Rollback

		******************** Metodo chamado pelos Objetos na Validação
		*   USR_VALID -> Return .f. Não deixa o Usuario sair do objeto.

		******************** Metodo chamado pelos PageFrames
		*   USR_ACTIVE_PAGE -> Return .f. Para o Metodo.

		*- Inicio dos procedimentos do Usuario
		*- Testando qual o metodo que esta chamando o metodo entrada

		DO CASE
			CASE UPPER(XMETODO) = 'USR_SAVE_BEFORE'
			
			&&USERESERVA - JOAO CARLOS - 2019.11.26 - TRAVA PARA NÃO PERMITIR PEDIDO DE VENDA SEM NATUREZA. SOLICITAÇÃO GABI			
				IF (THISFORMSET.P_TOOL_STATUS = 'I' AND F_VAZIO(V_VENDAS_05.NATUREZA_SAIDA))
					MESSAGEBOX("NÃO É PERMITIDO ADICIONAR PEDIDO SEM NATUREZA. FAVOR ENTRE EM CONTATO COM FISCAL.")
					RETURN .F.
				ENDIF

			
			&&USERESERVA JOAO CARLOS - 2019.12.02 - REALIZA O DISPARO DE E-MAIL AO SALVAR O PEDIDO
			CASE UPPER(XMETODO) = 'USR_SAVE_AFTER'
			SET STEP ON
			*------------#1# USERESERVA - JOAO CARLOS 2020.01.29 - ALTERAÇÃO PARA MARUCHE PARA ALTERAÇÃO STATUS PEDIDO VENDA ------------*			
			&&processo de double check para validação da natureza
			&&pegando o cursor com as naturezas que geram ITR
				IF (INLIST(THISFORMSET.P_TOOL_STATUS, "I"))  && , "A" retirado solicitação
					
					&& verificando se o usuário possui permissão de alteração (usuaário do Departamento FINCANCEIRO ATACADO)	
					xUsuarioFinanceiroAtacado = thisformset.rsv_VerificaUsuarioFincanceioAtacado()
					
					SELECT V_NATUREZA_GERA_ITR
					GO TOP
					SCAN
						IF (NATUREZA_SAIDA == V_VENDAS_05.NATUREZA_SAIDA AND !xUsuarioFinanceiroAtacado)
							THISFORMSET.LX_FORM1.LX_PAGEFRAME1.PAGE1.LX_PAGEFRAME1.PAGE1.CMB_APROVACAO.VALUE = "E"			
							THISFORMSET.LX_FORM1.LX_PAGEFRAME1.PAGE1.LX_PAGEFRAME1.PAGE1.CMB_APROVACAO.ENABLED = .F.
							THISFORMSET.LX_FORM1.LX_PAGEFRAME1.PAGE1.LX_PAGEFRAME1.PAge1.TX_aprovado_por.Value = ""
							
							&& processo de disparo de e-mail
							IF (THISFORMSET.P_TOOL_STATUS = "I")
							
								TEXT TO XEXEC NOSHOW TEXTMERGE
								
								DECLARE @TEXTO   VARCHAR(MAX)   = ''
								
									SELECT @TEXTO = '<HTML><BODY >'
									SELECT @TEXTO = @TEXTO + 'O PEDIDO <strong>' + ?V_VENDAS_05.PEDIDO + '</strong> ESTA COM STATUS ' + '<strong> EM ESTUDO </strong> .' +'E PRECISA DA APROVAÇÃO DO CONTAS A RECEBER.'
									SELECT @TEXTO = @TEXTO + '</BODY></HTML>'
								
									EXEC P_RSV_ENVIA_EMAIL 	@to ='contasreceber@usereserva.com; data.atual@gmail.com', @subject = 'Venda - ',	@text	=@texto, @prioridade = 'NORMAL', @cabecalho_html	= 1
								
								ENDTEXT
								
								IF !F_UPDATE(XEXEC)
									MESSAGEBOX('ERRO AO ENVIAR E-MAIL PARA O CONTAS A RECEBER.',48,'ATENCAO')
								ELSE
									MESSAGEBOX('ESTA NATUREZA EXIGE APROVAÇÃO DO CONTAS A RECEBER. PEDIDO EM ESTUDO',0,'Alteração Status Pedido')
								ENDIF
							ENDIF						
							
							EXIT
							
						ELSE
							THISFORMSET.LX_FORM1.LX_PAGEFRAME1.PAGE1.LX_PAGEFRAME1.PAGE1.CMB_APROVACAO.ENABLED = .T.					
						ENDIF
					ENDSCAN
				ENDIF
			*------------#1# FIM USERESERVA - JOAO CARLOS 2020.01.29 - ALTERAÇÃO PARA MARUCHE PARA ALTERAÇÃO STATUS PEDIDO VENDA ------------*

			OTHERWISE
				RETURN .T.				
		ENDCASE
	ENDPROC
ENDDEFINE