sig Xbox {
	paginas: set Pagina,
	usuario: one Usuario
}

sig Usuario {}

sig Pagina{}

sig Biblioteca extends Pagina {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Loja extends Pagina {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Jogo {}
sig Aplicativo {}

sig Social extends Pagina {
	publicacoes: set Publicacao
}

abstract sig Publicacao {
	autor: one Usuario
}

-- Tipos de publicação
sig Screenshot extends Publicacao {}
sig Video extends Publicacao {}
sig Stream extends Publicacao{}

pred show[]{}
run show
