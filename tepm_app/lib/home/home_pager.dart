import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerCHT = TextEditingController();
  final TextEditingController _controllerhDia = TextEditingController();
  final TextEditingController _controllerDSem = TextEditingController();

  NumberFormat fn = NumberFormat("0");

  double hsDia = 0; //Horas por dia que você pode estudar.
  double dSem = 0; //Quantidade de dias por semana que você pode estudar.
  double cHt = 0; //Carga horária total do curso ou matéria.
  double tCpM = 1.5; //Tempo pra compensar o estudo.
  double tEpM = 0; //Semanas de estudo por matéria.
  double hPSemana = 0; //Resultado das horas por semana.
  double resumoHpdia = 0; //Resultado das horas por dia.

  _calcular() {
    /*A formula é feita da seguinte maneira, tEpM = cHt * tCpM / (hsDia! * dSem)
    tEpM = tempo de estudo por matéria.
    cHt = Carga horária total da matéria.
    tCpM = Tempo pra compensar o estudo.
    hsDia = São as horas que você estuda por dia.
    dSem = Quantidade de dias por semana que você pode estudar.
     Então fica assim; o tempo de estudo por matéria é igual a carga horária 
     total do curso multiplicado por 1,5, para aumentar o rendimento em 50%,
     dividido pelas horas que você pode estudar por dia, multiplicado pelos dias 
     da semana que você separou para o estudo, que é igual as semanas que você vai 
     separar para alcançar o seu objetivo.
     */
    double? hsDia = double.tryParse(_controllerhDia.text);
    double? dSem = double.tryParse(_controllerDSem.text);
    double? cHt = double.tryParse(_controllerCHT.text);

    if (cHt == null || dSem == null || hsDia == null) {
      setState(() {
        tEpM = 0;
        hPSemana = 0;
        hsDia = 0;
      });
    } else {
      setState(() {
        tEpM = cHt * tCpM / (hsDia! * dSem);
        hPSemana = hsDia! * dSem;
        resumoHpdia = hsDia!;
      });
    }
  }
  /* Aplicativo feito com o objetivo de facilitar a organização dos estudos.*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tempo de estudo por matéria',
            style: TextStyle(fontSize: 20.00),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20.00,
            ),
            const Text(
              'Formula para calcular',
              style: TextStyle(
                fontSize: 20.00,
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantas horas você pode estudar por dia?',
              ),
              controller: _controllerhDia,
            ),
            const SizedBox(
              height: 20.00,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantos dias você pode estudar por semana?',
              ),
              controller: _controllerDSem,
            ),
            const SizedBox(
              height: 20.00,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Carga horária total do curso ?',
              ),
              controller: _controllerCHT,
            ),
            const SizedBox(
              height: 10.00,
            ),
            ElevatedButton(
              onPressed: (() {
                _calcular();
              }),
              child: const Text(
                'Calcular',
                style: TextStyle(
                  fontSize: 20.00,
                ),
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            const Text(
              'Para alcançar o seu objetivo você vai estudar:',
              style: TextStyle(fontSize: 20.00),
            ),
            const SizedBox(
              height: 10.00,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 10.00),
                  child: Text(
                    fn.format(resumoHpdia),
                    style: const TextStyle(fontSize: 20.00),
                  ),
                ),
                const Text(
                  'horas por dia,',
                  style: TextStyle(fontSize: 20.00),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.00, right: 10.00),
                  child: Text(
                    fn.format(hPSemana),
                    style: const TextStyle(fontSize: 20.00),
                  ),
                ),
                const Text(
                  'horas por semana.',
                  style: TextStyle(fontSize: 20.00),
                ),
              ],
            ),
            const SizedBox(
              height: 10.00,
            ),
            Row(children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.00, right: 10.00),
                child: Text(
                  "Você precisará de",
                  style: TextStyle(
                    fontSize: 20.00,
                  ),
                ),
              ),
              Text(
                fn.format(tEpM),
                style: const TextStyle(
                  fontSize: 20.00,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'semanas para terminar.',
                  style: TextStyle(
                    fontSize: 20.00,
                  ),
                ),
              )
            ])
          ],
        ));
  }
}
