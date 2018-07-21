module xbox
sig Xbox {
	usuario: one Usuario
}

sig Usuario {
	paginas: some Pagina
}

abstract sig Pagina {}

sig Biblioteca extends Pagina {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

one sig Loja extends Pagina {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Jogo {}
sig Aplicativo {}

one sig Social extends Pagina {
	publicacoes: set Publicacao
}

abstract sig Publicacao {
	autor: one Usuario
}

-- Tipos de publicação
sig Screenshot extends Publicacao {}
sig Video extends Publicacao {}
sig Stream extends Publicacao{}

-- Predicados

pred temBiblioteca[x:Xbox]{}
pred temLoja[x:Xbox] {}
pred temSocial[x:Xbox] {}

pred temXbox[u:Usuario] {
	one u.~usuario
}

pred foiPublicado[p:Publicacao] {
	one p.~publicacoes
}

-- fatos
fact {
	all u:Usuario | temXbox[u]
	all p:Publicacao | foiPublicado[p]
}

fact {
	all b:Biblioteca | #armazenamentoJogos[b] <= 5
}

fact {
	all b:Biblioteca | #armazenamentoApps[b] <= 8
}

fact {
	all l:Loja | #promoJogos[l] + #promoApps[l] >= 10 and #promoJogos[l] + #promoApps[l] <= 20
}
fact {
	all x:Xbox | temLoja[x] and temSocial[x]
	all p:Publicacao | foiPublicado[p]
}

--funções
fun armazenamentoJogos[b:Biblioteca]: set Jogo {
	b.jogos
}

fun armazenamentoApps[b:Biblioteca]: set Aplicativo {
	b.aplicativos
}

fun promoJogos[l:Loja]: set Jogo {
	l.jogos
}

fun promoApps[l:Loja]: set Aplicativo {
	l.aplicativos
}


pred show[]{}
run show
