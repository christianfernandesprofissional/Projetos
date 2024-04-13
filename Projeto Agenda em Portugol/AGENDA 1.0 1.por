programa
{
	inclua biblioteca Util --> util
	inclua biblioteca Arquivos --> arq
	inclua biblioteca Texto --> txt
	inclua biblioteca Tipos --> tipo
	
	cadeia contatos[100][2]
	cadeia contatos_ordenados[100][2]
	
	// Variáveis globais do arquivo
	cadeia tipos_de_arquivo[] = {"Arquivos de texto|txt"} 
	cadeia caminho_arquivo
	inteiro ultima_posicao_vazia=0, resposta
	inteiro contato_desejado // necessário para a função escolha_contato()
	logico repetir = falso, iniciar = verdadeiro //necessário para a função escolha_contato()
	
	funcao inicio()
	{
		//Início do programa
		inicializar()
		
		//Carregar menu
		menuInicial()

		
		//Fim do progrAma, só será executado quando o usuário selecionar a opção "SAIR" no menu inicial
		finalizar_programa()
	}
	
	funcao inicializar()
	{
		cadeia enter
		escreva("Carregando sua lista telefônica")
		para(inteiro i=0; i<15; i++)
		{
			escreva(".")
			util.aguarde(200)	
		}

	
		escreva("\nPressione enter para iniciar!")
		leia(enter)

		limpa()
		
	}
	
	funcao finalizar_programa()
	{
		limpa()
		escreva("===============================\n")
		escreva("======== ATÉ LOGO!!! ==========\n")
		escreva("===============================\n")
		
		util.aguarde(1000)
	}
	//Função menu inicial, responsável por chamar todas as funções
	funcao menuInicial()
	{
		
		// Opção do menu escolhida pelo usuário
		inteiro opcaoEscolhida
		logico executarPrograma = verdadeiro

		enquanto(iniciar == verdadeiro)
		{
			escreva("===============================\n")
			escreva("======== BEM-VINDO!!! =========\n")
			escreva("===============================\n")
			
			escreva("\n1 - CARREGAR ARQUIVO\n2 - SAIR\n")
			leia(opcaoEscolhida)

			escolha(opcaoEscolhida)
			{
				caso 1: 
					carregar_arquivo()
					limpa()
				pare
				caso 2: 
					executarPrograma = falso
					iniciar = falso
				pare
				caso contrario:
					limpa()
					escreva("OPÇÃO INVÁLIDA!")
					util.aguarde(1000)
				pare
					
			}
		}
		//Laço para manter o menu funcionando até o final do programa
		enquanto(executarPrograma == verdadeiro)
		{

			
			escreva("\nO QUE VOCÊ DESEJA FAZER?\n")
			//lista de opções para o usuário
			escreva("\n1- CARREGAR NOVA LISTA.\n2- GRAVAR NOVO CONTATO. \n3- PESQUISAR CONTATO.\n4- LISTAR CONTATOS.\n5- SAIR\n")
			leia(opcaoEscolhida)
			limpa()



			
			// escolhas para tomar uma ação
			escolha(opcaoEscolhida)
			{
				caso 1: 
					carregar_arquivo()
					util.aguarde(1500)
					limpa()
				pare
				
				caso 2:
					logico gravar_novamente = verdadeiro
					inteiro resp
					enquanto(gravar_novamente == verdadeiro)
					{
						se(ultima_posicao_vazia < 100)
						{
							novo_contato()
							gravar_arquivo()
							escreva("CONTATO ADICIONADO COM SUCESSO!\n")
							util.aguarde(500)
							limpa()
							escreva("DESEJA ADICIONAR OUTRO CONTATO?")
							escreva("\n1 - SIM\n2 - NÃO\n")
							leia(resp)
							se(resp == 1)
								gravar_novamente = verdadeiro
	
							se(resp == 2)
								gravar_novamente = falso
								
							limpa()
						}
						senao
						{
							escreva("LIMITE DE CONTATOS ATINGIDO!")
							gravar_novamente = falso
							util.aguarde(1500)
							limpa()
						}
					}
				pare

				caso 3: 
					//escreva("CARREGA FUNÇÃO DE PESQUISAR CONTATO")
					buscar_nome()
					gravar_arquivo()
					limpa()
				pare


				//==================================================================

				caso 4: 
					util.aguarde(1500)
					escreva("\nCOMO VOCÊ DESEJA LISTAR?\n")
					//Opções para o usuário escolher
					escreva("\n1- ORDEM ALFABÉTICA.\n2- VISUALIZAR NOMES PELA LETRA ESCOLHIDA.")
					escreva("\n3- SOMENTE LISTAR.\n4- VOLTAR\n")
					leia(opcaoEscolhida)
					
					// Ações tomadas dependendo das escolhas 
					escolha(opcaoEscolhida)
					{
						caso 1: 
							lista_ordenada()
							util.aguarde(500)
							limpa()
						pare

						caso 2: 
							pesquisar_letra_inicial()
							util.aguarde(500)
							limpa()
						pare

						caso 3: 
							limpa()
							listar_contatos(contatos)
							util.aguarde(500)
							limpa()
						pare
						// caso a opção voltar seja escolhida, ele para o "escolha caso" e retorna ao laço do menu inicial
						caso 4:
				
						pare

						caso contrario:
							escreva("OPÇÃO INVÁLIDA!!!")
							util.aguarde(1500)
							limpa()
						pare
						
					}
					
				pare

				//================================================================================

				caso 5:
					executarPrograma = falso
				pare

				caso contrario:
					escreva("OPÇÃO INVÁLIDA!!!")
					util.aguarde(1500)
					limpa()
				pare
			}
		
		}
	}
	// Esta função carrega o arquivo e coloca nas matrizes
	funcao carregar_arquivo()
	{
		// Chama a função para limpar os dados da matriz "contatos"		
		limpar_memoria(contatos)
		limpar_memoria(contatos_ordenados)
	
		// Salva o caminho absoluto do arquivo selecionado pelo usuário
		caminho_arquivo = arq.selecionar_arquivo(tipos_de_arquivo, falso)

		se(caminho_arquivo == "")
		{
			escreva("SELECIONE UM ARQUIVO PARA INICIAR!")
			util.aguarde(1000)
			
		}
		senao
		{
	
			// Abre o arquivo e salva o endereço de memória
			inteiro endereco_arquivo = arq.abrir_arquivo(caminho_arquivo, arq.MODO_LEITURA)
	
			// Indice para varrer as linhas da matriz
			inteiro indice = 0
			ultima_posicao_vazia = 0
	
			// Fica em laço até encontrar o EOF
			enquanto(nao arq.fim_arquivo(endereco_arquivo))
			{
				// Armazena o texto da linha que está sendo lida e seta o ponteiro para a próxima linha
				cadeia linha_lida = arq.ler_linha(endereco_arquivo)
	
				// Verifica se a linha não está vazia
				se(linha_lida != "")
				{
					// Determina o tamanho da linha lida
					inteiro tamanho_linha = txt.numero_caracteres(linha_lida)
	
					// Armazena o índice do caracter divisor (no caso ';')
					inteiro posi_divisao = txt.posicao_texto(";", linha_lida, 0)	
	
					// Usa o caracter divisor e o tamanho da linha para dividir a linha em "nome" e "fone"
					cadeia nome = txt.extrair_subtexto(linha_lida, 0, posi_divisao)				
					cadeia fone = txt.extrair_subtexto(linha_lida, posi_divisao+1, tamanho_linha)
	
					// Adiciona os dados lidos à matriz
					contatos[indice][0] = nome
					contatos[indice][1] = fone
					contatos_ordenados[indice][0] = nome
					contatos_ordenados[indice][1] = fone
	
					// Incrementa índice e o número de linhas
					indice++		
					ultima_posicao_vazia++
				}
			}
			
			arq.fechar_arquivo(endereco_arquivo)
			limpa()
			escreva("ARQUIVO CARREGADO COM SUCESSO!")
			util.aguarde(1500)
			iniciar = falso
		}
		
	}
	// Esta função limpa a matriz passada no parâmetro
	funcao limpar_memoria(cadeia matriz_a_ser_limpa[][])
	{
		
		inteiro linha=0

		enquanto(linha < 100 e matriz_a_ser_limpa[linha][0] != "")
		{
			// Limpa os registros
			matriz_a_ser_limpa[linha][0] = ""
			matriz_a_ser_limpa[linha][1] = ""
			
			// Incrementa a variável linha
			linha++
		}
	}
	
	funcao novo_contato()
	{
		cadeia novo_nome, novo_fone
		inteiro comparar_nome = 0
		
		escreva("DIGITE UM NOVO NOME: ")
		leia(novo_nome)		
		novo_nome = txt.caixa_alta(novo_nome)

		enquanto(comparar_nome < ultima_posicao_vazia)
		{
			se(contatos[comparar_nome][0] == novo_nome )
			{
				limpa()
				escreva("ESTE NOME JÁ EXISTE!\n")
				escreva("\nDIGITE O NOME NOVAMENTE: ")
				leia(novo_nome)		
				novo_nome = txt.caixa_alta(novo_nome)
				comparar_nome = 0
			}
			senao
			{
				comparar_nome++
			}
		}

		novo_fone = mascara_de_fone()

		contatos[ultima_posicao_vazia][0] = novo_nome
		contatos[ultima_posicao_vazia][1] = novo_fone
		contatos_ordenados[ultima_posicao_vazia][0] = novo_nome
		contatos_ordenados[ultima_posicao_vazia][1] = novo_fone

		ultima_posicao_vazia++
	}
	// Esta função salva a matriz editada no arquivo txt
	funcao gravar_arquivo()
	{		
		cadeia divisao= ";"
		inteiro conta = 0
		
		inteiro arquivo = arq.abrir_arquivo(caminho_arquivo, arq.MODO_ESCRITA)
		
		enquanto(conta < 100 e contatos[conta][0] != "")
		{
			cadeia nova_linha = contatos[conta][0] + divisao + contatos[conta][1]
			
			arq.escrever_linha(nova_linha, arquivo)
			conta++
		}
		arq.fechar_arquivo(arquivo)
	}
	// Busca o nome de acordo com o texto digitado e possibiliata o usuário editar ou excluir o contato
	funcao buscar_nome()
	{
		cadeia nome_digitado, nome_fatiado, resp = "S"
		caracter resp_caracter = 'S'
		inteiro posi_inicial=0, posi_final=0, cont=0

		enquanto(resp_caracter == 'S')
		{
			limpa()		
	
			escreva("DIGITE O NOME QUE DESEJA BUSCAR: ")
			leia(nome_digitado)
			nome_digitado = txt.caixa_alta(nome_digitado)

			cont = 0
	
			enquanto(cont < 100 e contatos[cont][0] != "")
			{
				inteiro tamanho_nome_digitado = txt.numero_caracteres(nome_digitado)
				posi_inicial = 0
				
				enquanto(verdadeiro)
				{
					posi_final = txt.posicao_texto(" ", contatos[cont][0], posi_inicial)
	
					se(posi_final == -1)
					{
						posi_final = txt.numero_caracteres(contatos[cont][0])
					}
					se(posi_inicial > posi_final)
					{
						pare
					}
	
					nome_fatiado = txt.extrair_subtexto(contatos[cont][0], posi_inicial, posi_final)

					inteiro tamanho_nome_fatiado = txt.numero_caracteres(nome_fatiado)

					se(tamanho_nome_digitado < tamanho_nome_fatiado)
					{
						cadeia nome_alterado = txt.extrair_subtexto(nome_fatiado, 0, tamanho_nome_digitado)
						se(nome_digitado == nome_alterado)
						{
							escreva(cont+1, "º\t", contatos[cont][0],"\t", contatos[cont][1],"\n")
						}
					
					}
	
					se(nome_digitado == nome_fatiado)
					{
						escreva(cont+1, "º\t", contatos[cont][0],"\t", contatos[cont][1],"\n")
						pare
					}
	
					posi_inicial = posi_final + 1
				}

				cont++
			}
			
			faca
			{
				escreva("\nDIGITE [S] PARA BUSCAR NOVAMENTE OU [C] PARA CANCELAR\n")
				escreva("CASO QUEIRA EXCLUIR OU EDITAR UM CONTATO, DIGITE O ÍNDICE\n")
				leia(resp)
				resp = txt.caixa_alta(resp)
				resp_caracter = txt.obter_caracter(resp, 0)
			}
			enquanto(resp_caracter != 'S' e resp_caracter != 'C' e tipo.cadeia_e_inteiro(resp, 10) == falso)	
		}

		se(tipo.cadeia_e_inteiro(resp, 10) == verdadeiro)
		{
			contato_desejado = tipo.cadeia_para_inteiro(resp, 10)

			faca
			{
				limpa()
				escreva("CONTATO ESCOLHIDO: ", contatos[contato_desejado-1][0], "\n")
				escreva("\nO QUE VOCÊ DESEJA FAZER?\n")
				escreva("1 - EDITAR CONTATO\n")
				escreva("2 - EXCLUIR CONTATO\n")
				escreva("3 - CANCELAR\n")
				leia(resp)

				se(tipo.cadeia_e_inteiro(resp, 10) == falso)
				{
					escreva("OPÇÃO INVÁLIDA!")
					util.aguarde(1000)
				}
			}
			enquanto(tipo.cadeia_e_inteiro(resp, 10) == falso e (tipo.cadeia_para_inteiro(resp, 10) < 1 ou tipo.cadeia_para_inteiro(resp, 10) > 3))

			limpa()

			escolha(tipo.cadeia_para_inteiro(resp, 10))
			{
				caso 1:
					editar_contatos()
				pare

				caso 2:
					excluir_contato()
				pare
				caso 3:
					
				pare
			}
		}

	}
	// Exibe a matriz recebida no parâmetro
	funcao listar_contatos(cadeia matriz_recebida[][])
	{
				
		inteiro cont, indice = 1, pag_inicio = 0, pag_fim = 20 
		cadeia resp, resp_maiuscula
		caracter resp_caracter
		

		faca
		{

			faca
			{	
				limpa()
				indice = pag_inicio +1
				para(cont = pag_inicio;cont < pag_fim;cont++)
				{

					se(matriz_recebida[cont][0] == "")
					{
						pare
					}
					senao
					{
						escreva(indice, "º\t",matriz_recebida[cont][0],"\t")
						escreva(matriz_recebida[cont][1],"\n")
						indice++
					}
				}
		
				escreva("\n\n[DIGITE 'N' PARA IR PARA PRÓXIMA PÁGINA, 'B' PARA PÁGINA ANTERIOR OU 'C' PARA CANCELAR]\n")
				leia(resp)
				resp_maiuscula = txt.caixa_alta(resp)
				resp_caracter = txt.obter_caracter(resp_maiuscula, 0)
				
				
			}enquanto(resp_caracter != 'N' e resp_caracter != 'B' e resp_caracter != 'C') 
		
		
		limpa()
		repetir = falso
		pag_inicio += 20
		pag_fim += 20
		se(resp_caracter == 'C')
		{
			repetir = verdadeiro
		}
		se(resp_caracter == 'B' e pag_inicio != 20 e pag_fim != 40)
		{
			pag_inicio -= 40
			pag_fim -= 40
		}
		se(resp_caracter == 'B' e pag_inicio == 20 e pag_fim == 40) //Esse código provavelmente está bem repetitivo 
		{
			pag_inicio = 0
			pag_fim = 20
			indice = pag_inicio +1
			escreva(indice, "º ",contatos[cont][0],"\t")
			escreva(contatos[cont][1],"\n")
		}

		se(indice >= 100 ou (contatos[indice][0] == "" e resp_caracter == 'N'))
		{
			limpa()
			escreva("ULTIMA PÁGINA ALCANÇADA\n")
			util.aguarde(1000)
			escreva("RETORNANDO PARA O INÍCIO.......\n")
			util.aguarde(1000)
			limpa()
			pag_inicio = 0
			pag_fim = 20
		}

		se(tipo.cadeia_e_inteiro(resp, 10) == verdadeiro)
		{
			repetir = verdadeiro
			contato_desejado = tipo.cadeia_para_inteiro(resp,10)
			
		}
		
		}enquanto(repetir == falso)
		repetir = falso
	}
	
	funcao editar_contatos()
	{
		limpa()
		cadeia novo_nome, novo_numero
		inteiro cont = 0

		repetir = verdadeiro
		
		enquanto(repetir == verdadeiro)
		{
			escreva("1 - EDITAR NOME\n2 - EDITAR NÚMERO\n")
			leia(resposta)
	
		
			se(resposta == 1)
			{
				escreva("DIGITE NOVO NOME DESEJADO: ")
				leia(novo_nome)
				novo_nome = txt.caixa_alta(novo_nome)

				contatos[contato_desejado - 1][0] = novo_nome
				escreva("NOME ALTERADO COM SUCESSO!")
				util.aguarde(1000)
				repetir = falso
			}senao se(resposta == 2)
			{
				novo_numero = mascara_de_fone()
				contatos[contato_desejado - 1][1] = novo_numero
				escreva("NÚMERO ALTERADO COM SUCESSO!")
				util.aguarde(1000)
				repetir = falso
			}senao
			{
				escreva("OPÇÃO INVÁLIDA")
			}
		}

		salvar_na_matriz_ordenada()
	}
	
	funcao excluir_contato()
	{
		contato_desejado--
		
		se(contato_desejado >= 0 e contato_desejado <= 100 e contatos[contato_desejado][0] != "")
		{	 
		      contatos[contato_desejado][0] = ""
		      contatos[contato_desejado][1] = ""

		      enquanto((contato_desejado + 1) < 100 e contatos[contato_desejado + 1][0] != "")
		      {
		        contatos[contato_desejado][0] = contatos[contato_desejado + 1][0]
		        contatos[contato_desejado][1] = contatos[contato_desejado + 1][1]
		
		        contatos[contato_desejado + 1][0] = ""
		        contatos[contato_desejado + 1][1] = ""

			   contato_desejado++		       
		      }

		      salvar_na_matriz_ordenada()

		      escreva("CONTATO DELETADO COM SUCESSO!")
			 util.aguarde(1000)
			 ultima_posicao_vazia--
			
		}
		senao
		{
			escreva("CONTATO NÃO ENCONTRADO!")
			util.aguarde(500)
		}
	}
	// ordena a matriz
	funcao lista_ordenada()
	{
	
		para(inteiro cont = 99; cont >= 0; cont--)
		{
			para(inteiro indice = 0;indice < cont;indice++)
			{
				se(contatos_ordenados[indice+1][0] != "")
				{
					
					inteiro comparado = compara(contatos_ordenados[indice][0],contatos_ordenados[indice+1][0])
					
					cadeia cache_nome = contatos_ordenados[indice][0]
					cadeia cache_fone = contatos_ordenados[indice][1]

					se(comparado == 1)
					{
						contatos_ordenados[indice][0] = contatos_ordenados[indice+1][0]
						contatos_ordenados[indice+1][0] = cache_nome

						
						contatos_ordenados[indice][1] = contatos_ordenados[indice+1][1]
						contatos_ordenados[indice+1][1] = cache_fone
					}
				}
				
				senao
				{
					pare
				}
			
			}
		}
		listar_contatos(contatos_ordenados)
	}
	// compara dois nomes da matriz e retorna -1, 0 ou 1
	funcao inteiro compara(cadeia nome1, cadeia nome2)
	{
		inteiro tamanho_nome1 = txt.numero_caracteres(nome1)
		inteiro tamanho_nome2 = txt.numero_caracteres(nome2)
		se(nome1 == nome2)
			retorne 0
			
		senao se(tamanho_nome1 < tamanho_nome2)
		{
			para(inteiro pos = 0;pos < tamanho_nome1;pos++)
			{
				se(txt.obter_caracter(nome1, pos) < txt.obter_caracter(nome2, pos))
					retorne -1
				senao se(txt.obter_caracter(nome1, pos) > txt.obter_caracter(nome2, pos))
					retorne 1
			}
			retorne -1
		}
		senao
		{
			para(inteiro pos = 0;pos <tamanho_nome2;pos++)
			{
				se(txt.obter_caracter(nome1, pos) < txt.obter_caracter(nome2, pos))
					retorne -1
					
				senao se(txt.obter_caracter(nome1, pos) > txt.obter_caracter(nome2, pos))
					retorne 1
			}
			retorne 1
		}
	}
	// Adiciona máscara ao telefone e valida a entrada de dados
	funcao cadeia mascara_de_fone()
	{
		cadeia fone_digitado
		cadeia ddd, cinco_digitos, quatro_digitos
		faca
		{
			escreva("DIGITE O NOVO NÚMERO: ")
			leia(fone_digitado)

			se(txt.numero_caracteres(fone_digitado) != 11 ou nao tipo.cadeia_e_inteiro(fone_digitado, 10) ou (txt.posicao_texto("-", fone_digitado, 0) != -1))
			{
				limpa()
				escreva("\nNÚMERO INVÁLIDO!!!!!!!\n")
			}
		}
		enquanto(txt.numero_caracteres(fone_digitado) != 11 ou nao tipo.cadeia_e_inteiro(fone_digitado, 10) ou (txt.posicao_texto("-", fone_digitado, 0) != -1))
		
		ddd = txt.extrair_subtexto(fone_digitado, 0, 2)
		cinco_digitos = txt.extrair_subtexto(fone_digitado, 2, 7)
		quatro_digitos = txt.extrair_subtexto(fone_digitado, 7, 11)

		retorne '(' + ddd + ") " + cinco_digitos + '-' + quatro_digitos
				
	}
	//Salva as edições feitas na matriz principal na matriz ordenada
	funcao salvar_na_matriz_ordenada()
	{
		limpar_memoria(contatos_ordenados)
		
		inteiro cont = 0
		
		enquanto(cont < 100 e contatos[cont][0] != "")
		{
			contatos_ordenados[cont][0] = contatos[cont][0]
			contatos_ordenados[cont][1] = contatos[cont][1]
			cont++
		}
	}
	// Busca os nomes pela letra escolhida pelo usuário
	funcao pesquisar_letra_inicial()
	{
		cadeia resp
		caracter letra_escolhida
		resposta = 1
		limpa()
		
		
			enquanto(resposta == 1)
			{	
				faca
				{
				
					escreva("DIGITE A LETRA DESEJADA: ")
					leia(resp)
					resp = txt.caixa_alta(resp)
					letra_escolhida = txt.obter_caracter(resp, 0)
					se(txt.numero_caracteres(resp) > 1)
					{
						escreva("POR FAVOR, DIGITE SOMENTE UM CARACTER")
						util.aguarde(1000)
					}
					limpa()
				}enquanto(txt.numero_caracteres(resp) > 1)
					
					para(inteiro i = 0; i < ultima_posicao_vazia; i++)
					{
						se(txt.obter_caracter(contatos[i][0], 0) == letra_escolhida)
						{
							escreva(i + 1, "º ", contatos[i][0], contatos[i][1], "\n")
							repetir = verdadeiro
						}
						senao se (i == ultima_posicao_vazia -1)
						{
								se(repetir == falso)
								{ 
									escreva("NENHUM NOME FOI ENCONTRADO!!!")
									util.aguarde(1000)
									limpa()
									pare
								}
						}
					}
					faca
					{
						escreva("\nDESEJA FAZER UMA NOVA PESQUISA?")
						escreva("\n1 - SIM\n2 - NÃO\n")
						leia(resposta)
						repetir = falso
						limpa()
						se(resposta != 1 e resposta != 2)
						{
							escreva("DIGITE UM DADO VÁLIDO!!!")
							util.aguarde(1000)
							limpa()
						}
					}enquanto(resposta != 1 e resposta != 2)
				
				
			}
		repetir = falso
	}
}


/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 981; 
 * @DOBRAMENTO-CODIGO = [17, 48, 58, 218, 283, 299, 335, 352, 464, 548, 588, 622, 658, 690, 715, 729];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {ultima_posicao_vazia, 14, 9, 20}-{repetir, 16, 8, 7};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */