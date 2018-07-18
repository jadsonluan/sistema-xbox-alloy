sig Xbox {
	paginas: some  Pagina,
	usuario: one Usuario
}

sig Usuario {}

abstract sig Pagina{}

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
pred temLoja[x:Xbox] {}
pred temSocial[x:Xbox] {}

pred foiPublicado[p:Publicacao] {}

-- fatos
fact {
	all x:Xbox | temLoja[x] and temSocial[x]
	all p:Publicacao | foiPublicado[p]
}

pred show[]{}
run show
