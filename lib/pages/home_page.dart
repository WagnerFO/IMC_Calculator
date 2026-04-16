import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/resultado_page.dart';
import 'package:flutter_application_1/services/imc_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mostrarFormulario = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mostrarFormulario = true;
      });
    });
  }

  @override
  void dispose() {
    nome.dispose();
    altura.dispose();
    peso.dispose();
    super.dispose();
  }

  TextEditingController nome = TextEditingController();
  TextEditingController altura = TextEditingController();
  TextEditingController peso = TextEditingController();

  final ImcService service = ImcService();

  void calcular() {
    String nomeDigitado = nome.text.trim();

    double alturaValor = service.tratarAltura(altura.text);
    double pesoValor = service.tratarPeso(peso.text);

    if (nomeDigitado.isEmpty || alturaValor == 0 || pesoValor == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Preencha os dados corretamente"),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    double imc = service.calcularIMC(pesoValor, alturaValor);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoPage(nome: nomeDigitado, imc: imc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,

                alignment: mostrarFormulario
                    ? Alignment.topCenter
                    : Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: mostrarFormulario ? 30 : 0),
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/yc_iTThxehE0XKnspc_d9Hal_OgRAPY-9SeTKw_HnT1SMG_CEEkU02Xk2Y0-t-MTEQ=w240-h480-rw',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: mostrarFormulario ? 0 : 1,
                    child: Text(
                      'Calculadora IMC',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: mostrarFormulario ? 1 : 0,
                  child: AnimatedPadding(
                    duration: const Duration(seconds: 1),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: mostrarFormulario ? 40 : 0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: nome,
                            decoration: InputDecoration(
                              labelText: "Nome",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            controller: altura,
                            decoration: InputDecoration(
                              labelText: "Altura",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            controller: peso,
                            decoration: InputDecoration(
                              labelText: "Peso",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 5,
                            ),
                            onPressed: calcular,
                            child: const Text(
                              'Calcular',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
