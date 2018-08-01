module xbox
-------------------------------------------------------
-------------------- A S S I N A T U R A S  |
-------------------------------------------------------
sig Xbox {
	usuario: one Usuario
}

sig Usuario {
	social: set Social,
	biblioteca: set Biblioteca,
	loja: set Loja,
	podeComprarJogo: set Jogo,
	podeComprarApp: set Aplicativo
}

sig Biblioteca {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

one sig Loja {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Jogo {}
sig Aplicativo {}

one sig Social {
	publicacoes: set Publicacao
}

abstract sig Publicacao {
	autoria: one Usuario
}

-- Tipos de publicação
sig Screenshot extends Publicacao {}
sig Video extends Publicacao {}
sig Stream extends Publicacao{}

-- Estados da publicação
sig Curtida, Compartilhamento {
	autoria: one Usuario,
	publicacao: one Publicacao
}

sig Comentario {
	autoria: one Usuario,
	transmissao: one Stream
}

----------------------------------------------------
-------------------- P R E D I C A D O S |
----------------------------------------------------
pred temBiblioteca[u:Usuario]{ one u.biblioteca }
pred temLoja[u:Usuario] { one u.loja }
pred temSocial[u:Usuario] { one u.social }
pred temXbox[u:Usuario] { one u.~usuario }

pred temUsuario[b:Biblioteca] { one b.~biblioteca }

pred foiPublicado[p:Publicacao] {	one p.~publicacoes }

pred temUsuario[c:Curtida] { one c.autoria}
pred temPublicacao[c:Curtida] { one c.publicacao }

pred temUsuario[c:Compartilhamento] { one c.autoria }
pred temPublicacao[c:Compartilhamento] { one c.publicacao}

pred temUsuario[c:Comentario] { one c.autoria }
pred temStream[c:Comentario] { one c.transmissao }

-------------------------------------
-------------------- F A T O S |
-------------------------------------
fact {
	all u:Usuario | u.podeComprarJogo = jogosNaoAdquiridos[u]
	all u:Usuario | u.podeComprarApp = appsNaoAdquiridos[u]
	all u:Usuario | temXbox[u]
	all u:Usuario | temLoja[u] and temSocial[u] and temBiblioteca[u]
	
	all p:Publicacao | foiPublicado[p]	
	
	all c:Curtida | temUsuario[c] and temPublicacao[c]
	all c:Compartilhamento | temUsuario[c] and temPublicacao[c]
	all c:Comentario | temUsuario[c] and temStream[c]

	all b:Biblioteca | #armazenamentoJogos[b] < 6
	all b:Biblioteca | #armazenamentoApps[b] < 9
	all b:Biblioteca | temUsuario[b]
	
	all l:Loja | #(promoJogos[l] + promoApps[l])  > 9 and #(promoJogos[l] + promoApps[l]) < 21
}

--------------------------------------------
-------------------- F U N Ç Õ E S 
--------------------------------------------
fun armazenamentoJogos[b:Biblioteca]: set Jogo { b.jogos }
fun armazenamentoApps[b:Biblioteca]: set Aplicativo { b.aplicativos }
fun promoJogos[l:Loja]: set Jogo {l.jogos }
fun promoApps[l:Loja]: set Aplicativo {l.aplicativos }
fun jogosNaoAdquiridos[u:Usuario]: set Jogo {u.loja.jogos - u.biblioteca.jogos }
fun appsNaoAdquiridos[u:Usuario]: set Aplicativo {u.loja.aplicativos - u.biblioteca.aplicativos }

----------------------------------------
-------------------- T E S T E S |
----------------------------------------
assert testMinimoDaLoja { all l:Loja | #(promoJogos[l] + promoApps[l])  > 9 }
assert testMaximoDaLoja { all l:Loja | #(promoJogos[l] + promoApps[l])  < 21 }
assert testArmazenamentoJogos {	all b:Biblioteca | #armazenamentoJogos[b] < 6 }
assert testArmazenamentoApps { all b:Biblioteca | #armazenamentoApps[b] < 9 }

check testMinimoDaLoja for 10
check testMaximoDaLoja for 20
check testArmazenamentoJogos for 20
check testArmazenamentoApps for 20

pred show[]{}
run show for 10
