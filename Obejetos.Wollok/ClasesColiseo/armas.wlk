// Arranquemos por las armas. Entre las armas más comunes que se usaban estaban las armas de filo como espadas, dagas o hachas. Las armas de filo aportan un valor de ataque equivalente al filo del arma multiplicado por su longitud. (La longitud de las armas de filo se mide en centímetros y su filo es un número entre 0 y 1.) Una alternativa para estas armas eran las llamadas contundentes, como por ejemplo mazas y martillos, que eran las preferidas de los gladiadores más brutos. Las armas contundente aportan un poder de ataque igual al peso del arma. Los gladiadores pueden cambiar sus armas

class ArmaFilosa {
	var longitud
	var filo

	method poderAtaque() {
		return longitud * filo
	}
}

class ArmaContundente {
	var peso

	method poderAtaque() {
		return peso
	}
}

