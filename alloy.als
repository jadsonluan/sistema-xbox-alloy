module xbox
sig Xbox {
	usuario: one Usuario
}

sig Usuario {
	social: one Social,
	biblioteca: one Biblioteca,
	loja: one Loja
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
	autor: one Usuario
}

-- Tipos de publicação
sig Screenshot extends Publicacao {}
sig Video extends Publicacao {}
sig Stream extends Publicacao{}

-- Predicados
pred temBiblioteca[u:Usuario]{
	one u.biblioteca
}

pred temLoja[u:Usuario] {
	one u.loja
}

pred temSocial[u:Usuario] {
	one u.social
}

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
	all b:Biblioteca | #armazenamentoJogos[b] <= 5
	all b:Biblioteca | #armazenamentoApps[b] <= 8
	all l:Loja | #promoJogos[l] + #promoApps[l] >= 10 and #promoJogos[l] + #promoApps[l] <= 20
	all u:Usuario | temLoja[u] and temSocial[u]
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
