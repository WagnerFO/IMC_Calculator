import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/gauge_widget.dart';
import 'package:flutter_application_1/services/imc_services.dart';

class ResultadoPage extends StatefulWidget {
  final String nome;
  final double imc;

  const ResultadoPage({super.key, required this.nome, required this.imc});

  @override
  State<ResultadoPage> createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animacao;

  final ImcService service = ImcService();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    animacao = Tween<double>(
      begin: 10,
      end: widget.imc,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String classificacao = service.classificarIMC(widget.imc);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Resultado IMC'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: animacao,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(child: IMCGauge(imcValue: animacao.value)),
                  const SizedBox(height: 0),
                  Transform.translate(
                    offset: const Offset(0, -160),
                    child: Text(
                      animacao.value.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Transform.translate(
                    offset: Offset(0, -140),
                    child: Text(
                      classificacao,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Transform.translate(
                    offset: Offset(0, -120),
                    child: Text(
                      "${widget.nome}, seu IMC é ${widget.imc.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Novo Calculo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
