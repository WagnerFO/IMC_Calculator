class ImcService {
  double tratarAltura(String texto) {
    texto = texto.trim().replaceAll(',', '.');

    double? altura = double.tryParse(texto);

    if (altura == null) return 0;
    if (!texto.contains('.') && altura > 3) {
      altura = altura / 100;
    }

    return altura;
  }

  double tratarPeso(String texto) {
    texto = texto.trim().replaceAll(',', '.');

    double? peso = double.tryParse(texto);

    if (peso == null) return 0;
    if (peso < 10 || peso > 400) return 0;

    return peso;
  }

  double calcularIMC(double peso, double altura) {
    return peso / (altura * altura);
  }

  String classificarIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc < 25) {
      return 'Peso Normal';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade I';
    } else if (imc < 40) {
      return 'Obesidade II';
    } else {
      return "Obesidade III";
    }
  }
}
