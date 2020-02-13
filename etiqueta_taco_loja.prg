*!*	**-- Cliente : Taco
*!*	**-- Conteudo: Programação Para Impressora 
*!*	**-------------------------------------------------------------------------------------------------------------------------**

*!*	Procedure Etiqueta_Taco_Loja_Varejo

*!*	**   1 2 11 002 0070 0010 DADO ENTER
*!*	**   | |  |   |    |    |
*!*	**   | |  |   |    |    +--> Coluna
*!*	**   | |  |   |    +-------> Linha
*!*	**   | |  |   +------------> Largura da Fonte
*!*	**   | |  +----------------> Altura  da Fonte
*!*	**   | +-------------------> Fonte
*!*	**   +---------------------> Rotação
*!*	*SET STEP ON

*!*	LOCAL xini,x_allegro,xfim 
*!*	xCtrlB   = '.'
*!*	xini     = xCtrlB +"L" + chr(13) + chr(10)+ "SK" + chr(13) + chr(10) + "PG" + chr(13) + chr(10) + "D11" + chr(13) + chr(10) + "H14" + chr(13) + chr(10)
*!*	*xini    = xCtrlB + "L"  + chr(13) + chr(10) + "SK" + chr(13) + chr(10) + "PG" + chr(13) + chr(10) + "D11" + chr(13) + chr(10) + "H14" + chr(13) + chr(10)
*!*	xfim     = "E" + chr(13) + chr(10) 
*!*	xQtdeEti = "Q0001" + chr(13) + chr(10) 
*!*	*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 

*!*	store '' to x_Allegro

*!*	sele vtmp_tabelas_preco_barra_00
*!*	go top

*!*	xColA = 010
*!*	xColB = 150
*!*	xColC = 290
*!*	xQtde = 0

*!*	do while !eof()	
*!*		store '' to xA1,xA2,xB1,xB2,xC1,xC2
*!*		*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 
*!*						
*!*		for k = 65 to 67
*!*			
*!*			
*!*			
*!*			*verifica tamanho - somente números para atender incompatibilidade de impressoras
*!*			xtamanho=ALLTRIM(vtmp_tabelas_preco_barra_00.nome_tamanho)
*!*			FOR i=1 TO LEN(xtamanho)
*!*				IF ASC(SUBSTR(xtamanho,i,1))<48 OR ASC(SUBSTR(xtamanho,i,1))>57 &&(asc0=48,asc9=57)
*!*					xtamanho=PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.tamanho)),2,'0')			
*!*					EXIT 
*!*				ENDIF 
*!*			ENDFOR				
*!*				
*!*			K_ = chr(k)				
*!*			
*!*			xQtde = xQtde + 1

*!*			* 1º PICOTE		
*!*			x&K_.1 = "19111010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
*!*			x&K_.2 = "19111050010"+PADL(xCol&K_,4,'0') + "R$  " + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco,12,2)) + chr(13) + chr(10)
*!*			*x&K_.3 = "1A020020001"+PADL(xCol&K_,4,'0') + "Por R$  " + xprecoPromocao + chr(13) + chr(10)
*!*			
*!*	        
*!*			if xQtde >= vtmp_tabelas_preco_barra_00.qtde_etiquetas
*!*				skip
*!*				xQtde = 0
*!*			endif

*!*			if eof()
*!*				exit
*!*			endif

*!*	endfor

*!*		x_Allegro = x_Allegro + xini + xA1+xA2+xB1+xB2+xC1+xC2;
*!*									     +xQtdeEti+xfim
*!*									     
*!*	 	sele vtmp_tabelas_preco_barra_00	                          
*!*	enddo

*!*	Return(allt(x_Allegro))
*!*	*---------------------------------------------------------------------------------------------------------------------------*

*!*	**-- Cliente : Taco
*!*	**-- Conteudo: Programação Para Impressora Datamax Allegro
*!*	**-------------------------------------------------------------------------------------------------------------------------**

*!*	Procedure Etiqueta_Taco_Loja_Promocao

*!*	**   1 2 11 002 0070 0010 DADO ENTER
*!*	**   | |  |   |    |    |
*!*	**   | |  |   |    |    +--> Coluna
*!*	**   | |  |   |    +-------> Linha
*!*	**   | |  |   +------------> Largura da Fonte
*!*	**   | |  +----------------> Altura  da Fonte
*!*	**   | +-------------------> Fonte
*!*	**   +---------------------> Rotação

*!*	xCtrlB   = ''
*!*	xini     = xCtrlB + "L" + chr(13) + chr(10) + "SK" + chr(13) + chr(10) + "PG" + chr(13) + chr(10) + "D11" + chr(13) + chr(10) + "H14" + chr(13) + chr(10)
*!*	xfim     = "E" + chr(13) + chr(10) 
*!*	xQtdeEti = "Q0001" + chr(13) + chr(10) 
*!*	*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 

*!*	store '' to x_Allegro

*!*	sele vtmp_tabelas_preco_barra_00
*!*	go top

*!*	xColA = 010
*!*	xColB = 150
*!*	xColC = 290
*!*	xQtde = 0

*!*	do while !eof()	
*!*		store '' to xA1,xA2,xA3,xA4,xA5,xB1,xB2,xB3,xB4,xB5,xC1,xC2,xC3,xC4,xC5
*!*		*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 
*!*						
*!*		for k = 65 to 67
*!*							
*!*			*verifica tamanho - somente números para atender incompatibilidade de impressoras
*!*			xtamanho=ALLTRIM(vtmp_tabelas_preco_barra_00.nome_tamanho)
*!*			FOR i=1 TO LEN(xtamanho)
*!*				IF ASC(SUBSTR(xtamanho,i,1))<48 OR ASC(SUBSTR(xtamanho,i,1))>57 &&(asc0=48,asc9=57)
*!*					xtamanho=PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.tamanho)),2,'0')			
*!*					EXIT 
*!*				ENDIF 
*!*			ENDFOR				
*!*				
*!*			K_ = chr(k)				
*!*			
*!*			xQtde = xQtde + 1

*!*			* 1º PICOTE		
*!*			x&K_.1 = "19111010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
*!*			x&K_.2 = "19111020021"+PADL(xCol&K_,4,'0') + "De  R$  "  + chr(13) + chr(10)
*!*			x&K_.3 = "19111020021"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco,12,2)) + chr(13) + chr(10)
*!*			x&K_.4 = "19111020001"+PADL(xCol&K_,4,'0') + "Por  R$  " + chr(13) + chr(10)
*!*			x&K_.5 = "19111050000"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco_promocao,12,2)) + chr(13) + chr(10)
*!*			
*!*	*!*			x&K_.1 = "19021010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
*!*	*!*			x&K_.2 = "19021010021"+PADL(xCol&K_,4,'0') + "De R$  " + xprecoVarejo + chr(13) + chr(10)
*!*	*!*			x&K_.3 = "19021010001"+PADL(xCol&K_,4,'0') + "Por R$  " + xprecoPromocao + chr(13) + chr(10)
*!*			
*!*	        
*!*			if xQtde >= vtmp_tabelas_preco_barra_00.qtde_etiquetas
*!*				skip
*!*				xQtde = 0
*!*			endif

*!*			if eof()
*!*				exit
*!*			endif

*!*	endfor

*!*		x_Allegro = x_Allegro + xini + xA1+xA2+xA3+xA4+xA5+xB1+xB2+xB3+xB4+xB5+xC1+xC2+xC3+xC4+xC5;
*!*									     +xQtdeEti+xfim
*!*									     
*!*	 	*Skip	                          
*!*	enddo

*!*	Return(allt(x_Allegro))
*---------------------------------------------------------------------------------------------------------------------------*

Procedure Etiqueta_Taco_Loja_Automatica

**   1 2 11 002 0070 0010 DADO ENTER
**   | |  |   |    |    |
**   | |  |   |    |    +--> Coluna
**   | |  |   |    +-------> Linha
**   | |  |   +------------> Largura da Fonte
**   | |  +----------------> Altura  da Fonte
**   | +-------------------> Fonte
**   +---------------------> Rotação

xCtrlB   = ''
xini     = xCtrlB + "L" + chr(13) + chr(10) + "SK" + chr(13) + chr(10) + "PG" + chr(13) + chr(10) + "D11" + chr(13) + chr(10) + "H14" + chr(13) + chr(10)
xfim     = "E" + chr(13) + chr(10) 
xQtdeEti = "Q0001" + chr(13) + chr(10) 
*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 

store '' to x_Allegro

sele vtmp_tabelas_preco_barra_00
go top

xColA = 010
xColB = 150
xColC = 290
xQtde = 0

do while !eof()	


	store '' to xA1,xA2,xA3,xA4,xA5,xB1,xB2,xB3,xB4,xB5,xC1,xC2,xC3,xC4,xC5
	*xQtdeEti = "Q"+ PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.qtde_etiquetas)),4,'0') + chr(13) + chr(10) 
					
	for k = 65 to 67
						
		*verifica tamanho - somente números para atender incompatibilidade de impressoras
		xtamanho=ALLTRIM(vtmp_tabelas_preco_barra_00.nome_tamanho)
		FOR i=1 TO LEN(xtamanho)
			IF ASC(SUBSTR(xtamanho,i,1))<48 OR ASC(SUBSTR(xtamanho,i,1))>57 &&(asc0=48,asc9=57)
				xtamanho=PADL(ALLTRIM(STR(vtmp_tabelas_preco_barra_00.tamanho)),2,'0')			
				EXIT 
			ENDIF 
		ENDFOR				
			
		K_ = chr(k)	
		xQtde = xQtde + 1
		
		f_select('select preco_liquido1 from produtos_preco_cor where produto=?vtmp_tabelas_preco_barra_00.produto and cor_produto=?vtmp_tabelas_preco_barra_00.cor_produto','tmp_preco',alias())
		sele vtmp_tabelas_preco_barra_00
		
		*PRODUTO TEM PROMOÇÃO POR PRODUTO
		IF tmp_preco.preco_liquido1 = 0 AND vtmp_tabelas_preco_barra_00.preco_promocao > 0
		
		* 1º PICOTE		
			x&K_.1 = "19111010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
			x&K_.2 = "19111020021"+PADL(xCol&K_,4,'0') + "De  R$  "  + chr(13) + chr(10)
			x&K_.3 = "19111020021"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco,12,2)) + chr(13) + chr(10)
			x&K_.4 = "19111020001"+PADL(xCol&K_,4,'0') + "Por  R$  " + chr(13) + chr(10)
			*x&K_.5 = "19111050000"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(tmp_preco.preco_liquido1,12,2)) + chr(13) + chr(10)
			x&K_.5 = "19111050000"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco_promocao,12,2)) + chr(13) + chr(10)
		ENDIF
		
		
		*PRODUTO NÃO TEM PROMOÇÃO
		IF tmp_preco.preco_liquido1 = 0 AND vtmp_tabelas_preco_barra_00.preco_promocao = 0
		
			x&K_.1 = "19111010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
			x&K_.2 = "19111050010"+PADL(xCol&K_,4,'0') + "R$  " + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco,12,2)) + chr(13) + chr(10)
			*x&K_.2 = "19111050010"+PADL(xCol&K_,4,'0') + "R$  " + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco_promocao,12,2)) + chr(13) + chr(10)
			x&K_.3 = ""
			x&K_.4 = ""
			x&K_.5 = ""
		ENDIF 
		
		
		*f_select('select preco_liquido1 from produtos_preco_cor where produto=?vtmp_tabelas_preco_barra_00.produto and cor_produto=?vtmp_tabelas_preco_barra_00.cor_produto','tmp_preco',alias())

		*PRODUTO TEM PROMOÇÃO POR COR

		IF tmp_preco.preco_liquido1 > 0

			* 1º PICOTE		
			x&K_.1 = "19111010038"+PADL(xCol&K_,4,'0') + "Ref  " + allt(vtmp_tabelas_preco_barra_00.produto) + chr(13) + chr(10)
			x&K_.2 = "19111020021"+PADL(xCol&K_,4,'0') + "De  R$  "  + chr(13) + chr(10)
			x&K_.3 = "19111020021"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco,12,2)) + chr(13) + chr(10)
			x&K_.4 = "19111020001"+PADL(xCol&K_,4,'0') + "Por  R$  " + chr(13) + chr(10)
			x&K_.5 = "19111050000"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(tmp_preco.preco_liquido1,12,2)) + chr(13) + chr(10)
			*x&K_.5 = "19111050000"+PADL(xCol&K_+50,4,'0') + ALLTRIM(STR(vtmp_tabelas_preco_barra_00.preco_promocao,12,2)) + chr(13) + chr(10)
		ENDIF
        
		if xQtde >= vtmp_tabelas_preco_barra_00.qtde_etiquetas
			skip
			xQtde = 0
		endif

		if eof()
			exit
		endif

endfor

	x_Allegro = x_Allegro + xini + xA1+xA2+xA3+xA4+xA5+xB1+xB2+xB3+xB4+xB5+xC1+xC2+xC3+xC4+xC5;
								 +xQtdeEti+xfim
								     
 	*Skip	                          
enddo

Return(allt(x_Allegro))
