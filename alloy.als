sig Xbox {
	biblioteca: one Biblioteca,
	social: one Social,
	loja: one Loja,
	-- tem apenas um usuário?
	usuario: one Usuario
}

sig Usuario {}

sig Biblioteca {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Loja {
	jogos: set Jogo,
	aplicativos: set Aplicativo
}

sig Jogo {}
sig Aplicativo {}

sig Social {
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
