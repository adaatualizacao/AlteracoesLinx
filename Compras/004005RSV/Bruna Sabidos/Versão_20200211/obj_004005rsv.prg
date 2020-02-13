******************************************************
*- Programa Base de Cria��o de Objeto de Entrada
********************************************************************
*- O programa deve ser texto com o nome = OBJ_xxxxxx.prg onde x=numero da tela
*- Este arquivo deve ser colocado no diretorio \Linx_sql\Linx\Exclusivos 
*******************************************************************************
*- Existem 2 parametros que influem nos objetos de Entrada:  
*  utiliza_objeto_entrada = .f. desliga os objetos de entrada para testar telas sem os mesmos
*  mostra_nome_obj = .t. mostra o nome dos objetos no tooltip em tempo de execu��o para facilitar o desenvolvimento
*********************************************************************************


*********************************************************************************
* - Atencao !!!!!!!!!!!														   -*
* - Toda vez que houver qualquer alteracao no PRG deve-se apagar o arquivo FXP -*
*********************************************************************************

*
*                 Abaixo segue Programa objeto sem Codigo 
*
*
*- Definindo a classe do objeto de entrada que sera criado na Form.
define class obj_entrada as custom
	*- Nome do metodo/fun��o que os objetos linx v�o chamar.
	procedure metodo_usuario
		*- Parametros do metodo:
		*- Xmetodo= nome do metodo
		*- Xobjeto= variavel com a referencia ao objeto
		*- Xnome_obj  = nome do objeto
		lparam xmetodo, xobjeto ,xnome_obj
		
		******************** Metodos chamados pelo FORMSET
		*	USR_INIT
		*	USR_ALTER_BEFORE  ->Return .f. Para o Metodo
		*	USR_ALTER_AFTER    
		*	USR_INCLUDE_AFTER
		*	USR_SEARCH_BEFORE ->Return .f. Para o Metodo
		*	USR_SEARCH_AFTER
		*	USR_CLEAN_AFTER
		*	USR_REFRESH
		*	USR_SAVE_BEFORE   ->Return .f. Para o Metodo 
		*	USR_SAVE_AFTER
		*	USR_ITEN_DELETE_BEFORE ->Return .f. Para o Metodo
		*	USR_ITEN_DELETE_AFTER
		*	USR_ITEN_INCLUDE_BEFORE ->Return .f. Para o Metodo
		*	USR_ITEN_INCLUDE_AFTER
		*
		***************** Metodos que ocorrem dentro da Transaction do Banco de Dados
		*	USR_TRIGGER_AFTER ->Return .f. Para o Salvamento e da Rollback
		*	USR_TRIGGER_BEFORE ->Return .f. Para o Salvamento e da Rollback


		******************** Metodo chamado pelos Objetos na Valida��o
		*   USR_VALID -> Return .f. N�o deixa o Usuario sair do objeto.

		*- Inicio dos procedimentos do Usuario
		*- Testando qual o metodo que esta chamando o metodo entrada

		do case
		
			*- metodo do inicio da form
			
			CASE UPPER(xmetodo) = 'USR_INIT'
				thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.enabled=.f.
				thisformset.lx_form1.lx_PAGEFRAME1.page1.tx_cadastramento.enabled=.f.				

				thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.enabled=.f.
				WITH thisform.lx_pageframe1.page1					    
*!*						.addobject('lb_desc_nat','lb_desc_nat')
					.addobject('tb_desc_nat','tb_desc_nat')												
				ENDWITH
					
				thisformset.l_limpa()
				o_toolbar.Botao_limpa.Click()		

			CASE UPPER(xmetodo) = 'USR_WHEN'
				thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.enabled=.f.								
				thisformset.lx_form1.lx_PAGEFRAME1.page1.tx_cadastramento.enabled=.f.	
				thisformset.lx_form1.lx_PAGEFRAME1.page2.ed_desc_consumivel.enabled=.f.			

			CASE UPPER(xmetodo) = 'USR_INCLUDE_AFTER'
				thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.enabled=.f.				
				thisformset.lx_form1.lx_PAGEFRAME1.page1.tx_cadastramento.enabled=.f.	
				*!*usereserva
				thisformset.lx_form1.lx_PAGEFRAME1.page2.ed_desc_consumivel.enabled=.f.	
				*!*usereserva
						

			CASE UPPER(xmetodo) = 'USR_ALTER_AFTER'
				thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.enabled=.f.				
				thisformset.lx_form1.lx_PAGEFRAME1.page1.tx_cadastramento.enabled=.f.
				*!*usereserva
				thisformset.lx_form1.lx_PAGEFRAME1.page2.ed_desc_consumivel.enabled=.f. 
				thisformset.lx_form1.lx_PAGEFRAME1.page2.LX_GRID_FILHA1.col_tv_RATEIO_FILIAL.enabled=.f.
				*!*usereserva
				
			CASE UPPER(xmetodo) = 'USR_ITEN_INCLUDE_AFTER'
				thisformset.lx_form1.lx_PAGEFRAME1.page2.LX_GRID_FILHA1.col_tv_RATEIO_FILIAL.enabled=.t.	
 			
 			*CASE UPPER(xmetodo) = 'USR_ALTER_BEFORE'
			*	IF (thisformset.lx_form1.lx_PAGEFRAME1.page1.cmb_status_compra.value='02') then
			*		f_select("SELECT COUNT(*)aprova FROM PARAMETROS_USERS WHERE PARAMETRO = 'APROVA_CONSUMIVEIS' AND VALOR_ATUAL_USER = '.T.' AND USUARIO=?wUsuario","cur_user") 
			*		IF cur_user.aprova=0 then
			*			messagebox('Pedidos aprovados n�o podem ser alterados.',016,"Aten��o")
			*			RETURN .f.
			*		ELSE return .t.
			*		ENDIF
			*	ELSE RETURN .t.
			*	ENDif



*!*-----------------------------------------------------USERESERVA-----------------------------------------------------------------------------

					
					CASE UPPER(xmetodo) = 'USR_SAVE_BEFORE'
					
					SET STEP ON
										
					* joao carlos - 13.11.2018 - mensagem de estouro de valor (Solicita��o Claudio)
					If InList(ThisFormSet.p_Tool_Status, "I", "A")
					
					thisformset.lx_forM1.lx_pageframe1.ActivePage = 2
					thisformset.lx_FORM1.lx_pageframe1.page2.lx_GRID_FILHA1.col_TV_CODIGO_ITEM.SetFocus()

					*-variaveis do m�s e ano
					SELECT v_compras_01_consumivel
					

					if(thisformset.lx_forM1.lx_pageframe1.page2.ck_CTRL_MULT_ENTREGAS.value)
					
					SELECT v_compras_01_consumivel
					GO top
						SCAN
						
							xMes = MONTH(entrega)
							xAno = YEAR(entrega)
							
								* consulta Centro de Custo								
								TEXT TO xVal NOSHOW textmerge
									SELECT centro_custo, inativo FROM RSV_ORCAMENTO_CENTRO_CUSTO WHERE centro_custo = '<<RATEIO_CENTRO_CUSTO>>' AND inativo = 0
								ENDTEXT
									f_select (xVal, 'Cur_centro_custo', ALIAS())
								
								
									
								*valor j� realizado								
								TEXT TO xGast NOSHOW textmerge
										SELECT	 ISNULL(SUM(a.custo), 0) as Gasto
										FROM	COMPRAS_CONSUMIVEL a
										JOIN	COMPRAS b ON(a.PEDIDO = b.PEDIDO)
										WHERE	a.RATEIO_CENTRO_CUSTO = '<<Cur_centro_custo.centro_custo>>' 
												AND YEAR(a.ENTREGA) = '<<xAno>>' AND MONTH(a.entrega) = '<<xMes>>'
												AND b.STATUS_APROVACAO IN('A','P')
												AND a.CONTA_CONTABIL NOT LIKE '10%'
								ENDTEXT
									f_select(xGast, 'Cur_gasto', ALIAS())
									
								xGasto = Cur_gasto.Gasto
								
							
								* descri��o centro de custo								
								TEXT TO xDesc NOSHOW textmerge
									SELECT	DESC_CENTRO_CUSTO FROM	CTB_CENTRO_CUSTO WHERE centro_custo = '<<Cur_centro_custo.centro_custo>>'
								ENDTEXT
									f_select(xDesc, 'Cur_desc_custo', ALIAS())

								xDesc_custo = Cur_desc_custo.desc_centro_custo

							
							* condi��o para valida��o pelo centro de custo
							IF !f_vazio(Cur_centro_custo.centro_custo) then

								* cursor valor Orcado
								TEXT TO xVo NOSHOW textmerge
									SELECT	ISNULL(sum(valor),0) as valor FROM W_RSV_ORCAMENTO WHERE centro_custo = '<<Cur_centro_custo.centro_custo>>' AND ano = '<<xAno>>'  AND mes = '<<xMes>>'
								ENDTEXT
								f_select (xVo, 'Cur_Valor_Orcado', ALIAS())

								* declara��o de valores em vari�veis
								xValorOrcado = Cur_Valor_Orcado.valor
								xValorEmpenhado =  custo &&thisformset.lx_FORM1.lx_pageframe1.page1.Tx_total_padrao.Value
								xValorEstouro = (xValorOrcado - xValorEmpenhado)
								xPedido = ALLTRIM(v_compras_01.pedido)


								* -joao carlos 2018.11.13 - usereserva - atribuindo o m�s relacionado(Na mensagem n�o � utilizado - deixei apenas para se houver alguma utilidade futura)
								DO case
									CASE xMes = 1 
										xMesDesc='Janeiro'
									CASE xMes = 2 
										xMesDesc='Fevereiro'
									CASE xMes = 3 
										xMesDesc='Mar�o'
									CASE xMes = 4 
										xMesDesc='Abril'
									CASE xMes = 5 
										xMesDesc='Maio'
									CASE xMes = 6 
										xMesDesc='Junho'
									CASE xMes = 7 
										xMesDesc='Julho'
									CASE xMes = 8 
										xMesDesc='Agosto'
									CASE xMes = 9 
										xMesDesc='Setembro'
									CASE xMes = 10 
										xMesDesc='Outubro'
									CASE xMes = 11 
										xMesDesc='Novembro'	
									CASE xMes = 12
										xMesDesc = 'Dezembro'
								ENDCASE

								xEmpenhado = xValorEmpenhado + xGasto

								if((xValorEmpenhado + xGasto) > (xValorOrcado))
								
									messagebox('Detectamos que o pedido '+ xPedido +' possui M�ltiplas Entegas  e item no valor de ' + cast(xValorEmpenhado as char(10)) + ' esta estourando o or�amento do centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o m�s de ' + cast(xMesDesc as varchar(10)) + '.' + CHR(13)+ CHR(13) +;
												'Recomendamos que voc� fa�a um exerc�cio de remanejamento ou prorroga��o dessa despesa junto ao time de Or�amento, caso seja poss�vel.',64,'Estouro Or�amento')
									
									*-messagebox('Prezado(a) Gestor(a)' + CHR(13) + CHR(13) +;
									'Detectamos que o pedido '+ xPedido +' possui M�ltiplas Entegas e possui um item no valor de ' + cast(xValorEmpenhado as char(10)) + ' esta estourando o or�amento do centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o m�s de ' + cast(xMesDesc as varchar(10)) + '.' + CHR(13) +;
									'D� uma olhada no demonstrativo abaixo:' + CHR(13) + CHR(13) +;
									'Total or�ado no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o periodo: ' + cast(xValorOrcado as char(10)) + CHR(13) + CHR(13)+;
									'Total gasto no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' no per�odo: ' + cast(xGasto as char(10)) + CHR(13) + CHR(13)+;
									'Estouro acumulado no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' : ' +  cast(xValorEstouro as char(10))  + CHR(13) + CHR(13)+;
									'Recomendamos que voc� fa�a um exerc�cio de remanejamento ou prorroga��o dessa despesa junto ao time de Or�amento, caso seja poss�vel.',64,'Estouro Or�amento')-*
									
								ENDIF
							
							*validando se a mensagem foi sim vai continuar o procedimento normal se for n�o ir� retornar falso
							IF messagebox.show("Or�amento estouro. Ainda quer salvar?", 32, "Pedido Estouro.", messageboxbuttons.YesNo) == 6

							ELSE
								RETURN .F.		
							ENDIF	
							ENDIF
							
								IF RECCOUNT('Cur_centro_custo')>0
									DELETE FROM Cur_centro_custo
								ENDIF
								
								IF RECCOUNT('Cur_gasto')>0
									DELETE FROM Cur_gasto
								ENDIF
								
								IF RECCOUNT('Cur_desc_custo')>0
									DELETE FROM Cur_desc_custo
								ENDIF
								
								
								IF RECCOUNT('Cur_Valor_Orcado')>0
									DELETE FROM Cur_Valor_Orcado
								ENDIF
								
								
												
						
					ENDSCAN
					
					ELSE
					xMes = MONTH(thisformset.lx_forM1.lx_pageframe1.page2.tx_ENTREGA_UNICA.Value)
					xAno = YEAR(thisformset.lx_forM1.lx_pageframe1.page2.tx_ENTREGA_UNICA.Value)
					
					
										* Consulta Centro de Custo
					TEXT TO xVal NOSHOW textmerge
						SELECT centro_custo, inativo FROM RSV_ORCAMENTO_CENTRO_CUSTO WHERE centro_custo = '<<V_COMPRAS_01_CONSUMIVEL.RATEIO_CENTRO_CUSTO>>' AND inativo = 0
					ENDTEXT
						f_select (xVal, 'Cur_centro_custo', ALIAS())
						
					*valor j� realizado
					TEXT TO xGast NOSHOW textmerge
							SELECT	 ISNULL(SUM(a.VALOR_ORIGINAL), 0) as Gasto
							FROM	COMPRAS_CONSUMIVEL a
							JOIN	COMPRAS b ON(a.PEDIDO = b.PEDIDO)
							WHERE	a.RATEIO_CENTRO_CUSTO = '<<Cur_centro_custo.centro_custo>>' 
									AND YEAR(a.ENTREGA) = '<<xAno>>' AND MONTH(a.entrega) = '<<xMes>>'
									AND b.STATUS_APROVACAO IN('A','P')
									AND a.CONTA_CONTABIL NOT LIKE '10%'
					ENDTEXT
						f_select(xGast, 'Cur_gasto', ALIAS())
						
					xGasto = Cur_gasto.Gasto

					*descri��o centro de custo
					TEXT TO xDesc NOSHOW textmerge
						SELECT	DESC_CENTRO_CUSTO FROM	CTB_CENTRO_CUSTO WHERE centro_custo = '<<Cur_centro_custo.centro_custo>>'
					ENDTEXT
						f_select(xDesc, 'Cur_desc_custo', ALIAS())

					xDesc_custo = Cur_desc_custo.desc_centro_custo

					*Condi��o para valida��o pelo centro de custo
					IF !f_vazio(Cur_centro_custo.centro_custo) then

					*Cursro valor Orcado
					TEXT TO xVo NOSHOW textmerge
					SELECT	ISNULL(sum(valor),0) as valor FROM W_RSV_ORCAMENTO WHERE centro_custo = '<<Cur_centro_custo.centro_custo>>' AND ano = '<<xAno>>'  AND mes = '<<xMes>>'
					ENDTEXT
					f_select (xVo, 'Cur_Valor_Orcado', ALIAS())

					*declara��o de valores em vari�veis
					xValorOrcado = Cur_Valor_Orcado.valor
					xValorEmpenhado = thisformset.lx_FORM1.lx_pageframe1.page1.Tx_total_padrao.Value
					xValorEstouro = (xValorOrcado - xValorEmpenhado)
					xPedido = ALLTRIM(v_compras_01.pedido)


					*-joao carlos 2018.11.13 - usereserva - atribuindo o m�s relacionado(Na mensagem n�o � utilizado - deixei apenas para se houver alguma utilidade futura)
					DO case
						CASE xMes = 1 
							xMesDesc='Janeiro'
						CASE xMes = 2 
							xMesDesc='Fevereiro'
						CASE xMes = 3 
							xMesDesc='Mar�o'
						CASE xMes = 4 
							xMesDesc='Abril'
						CASE xMes = 5 
							xMesDesc='Maio'
						CASE xMes = 6 
							xMesDesc='Junho'
						CASE xMes = 7 
							xMesDesc='Julho'
						CASE xMes = 8 
							xMesDesc='Agosto'
						CASE xMes = 9 
							xMesDesc='Setembro'
						CASE xMes = 10 
							xMesDesc='Outubro'
						CASE xMes = 11 
							xMesDesc='Novembro'	
						CASE xMes = 12
							xMesDesc = 'Dezembro'
					ENDCASE

					xEmpenhado = xValorEmpenhado + xGasto

					if((xValorEmpenhado + xGasto) > (xValorOrcado))
					 messagebox('Detectamos que o pedido '+ xPedido +' no valor de ' + cast(xValorEmpenhado as char(10)) + ' esta estourando o or�amento do centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o m�s de ' + cast(xMesDesc as varchar(10)) + '.' + CHR(13) + CHR(13) +;
								'Recomendamos que voc� fa�a um exerc�cio de remanejamento ou prorroga��o dessa despesa junto ao time de Or�amento, caso seja poss�vel.',64,'Estouro Or�amento')
					
					
					
					*-messagebox('Prezado(a) Gestor(a)' + CHR(13) + CHR(13) +;
					'Detectamos que o pedido '+ xPedido +' no valor de ' + cast(xValorEmpenhado as char(10)) + ' esta estourando o or�amento do centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o m�s de ' + cast(xMesDesc as varchar(10)) + '.' + CHR(13) +;
					'D� uma olhada no demonstrativo abaixo:' + CHR(13) + CHR(13) +;
					'Total or�ado no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' para o periodo: ' + cast(xValorOrcado as char(10)) + CHR(13) + CHR(13)+;
					'Total gasto no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' no per�odo: ' + cast(xGasto as char(10)) + CHR(13) + CHR(13)+;
					'Estouro acumulado no centro de custo ' + cast(ALLTRIM(xDesc_custo) as varchar(20))  + ' : ' +  cast(xValorEstouro as char(10))  + CHR(13) + CHR(13)+;
					'Recomendamos que voc� fa�a um exerc�cio de remanejamento ou prorroga��o dessa despesa junto ao time de Or�amento, caso seja poss�vel.',64,'Estouro Or�amento')-*
					
					ENDIF
						IF messagebox.show("Or�amento estouro. Ainda quer salvar?", 32, "Pedido Estouro.", messageboxbuttons.YesNo) == 6
					ELSE
						RETURN .F.		
					ENDIF					
					
					ENDIF




					ENDIF
					ENDIF
					

*------------------------------------------------------------------fimusereserva---------------------------------------------------------


			CASE UPPER(xmetodo) == 'USR_REFRESH' and 'RESERVA' $ upper(system.data.sqldatabase)
				IF TYPE("thisformset.lX_form1.lx_pageframe1.page1.tb_desc_nat") = "O" AND NOT ISNULL(thisformset.lX_form1.lx_pageframe1.page1.tb_desc_nat)
					f_select("select DESC_NF from NATUREZAS_ENTRADAS where NATUREZA = ?v_compras_01.natureza_entrada","cur_natureza") 
					thisformset.lX_form1.lx_pageframe1.page1.tb_desc_nat.value = cur_natureza.desc_nf
				ENDIF
 					
			
			
			otherwise
				return .t.				
		endcase
	endproc
ENDDEFINE



**************************************************
*-- Class:        lb_desc_nat (e:\linx_sql_750\linx\exclusivos\lb_filial.vcx)
*-- ParentClass:  lx_label (c:\arquivos de programas\arquivos comuns\linx sistemas\desenv\lib\lx_class.vcx)
*-- BaseClass:    label
*
*!*	DEFINE CLASS lb_desc_NAT AS lx_label

*!*		visible=.t.
*!*		FontName = "Tahoma"
*!*		FontSize = 8
*!*		Alignment = 0
*!*		Caption = "Desc.Nat."
*!*		Left = 72
*!*		Top = 152
*!*		Name = "lb_desc_nat"
*!*	ENDDEFINE
*
*-- EndDefine
**************************************************

**************************************************
*-- Class:        tb_desc_nat 
*
DEFINE CLASS tb_desc_nat AS lx_textbox_base
	
	visible=.f.
	Height = 18
	Left = 350
	Top = 54
	Width = 170	
	Name = 'tb_desc_nat'
	p_tipo_dado = "edita"
    enabled=.f.
	readonly = .t.
    
ENDDEFINE
*
*-- EndDefine 119 157
**************************************************



