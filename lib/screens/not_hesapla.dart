import 'package:dinamikortalamahesaplama/models/ders.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NotHesapla extends StatefulWidget {
  @override
  _NotHesaplaState createState() => _NotHesaplaState();
}

class _NotHesaplaState extends State<NotHesapla> {
  String dersAdi = "";
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  double ortalama = 0;
  static int sayac = 0;

  final formKey = GlobalKey<FormState>();

  List<Ders> tumDersler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Sayfasi"),
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            tumDersler
                .add(Ders(dersAdi, dersKredi, dersHarfDegeri, rastgeleRenk()));
            ortalama = 0;
            ortalamaHesapla();
          }
        },
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                //color: Colors.pink.shade200,
                child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ders Adi",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (value) {
                        if (value.length > 0) {
                          return null;
                        } else {
                          return "Ders adi bos birakilamaz";
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          dersAdi = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                items: dersKredirediItems(),
                                value: dersKredi,
                                onChanged: (value) {
                                  setState(() {
                                    dersKredi = value;
                                  });
                                }),
                          ),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                items: dersHarfDegeriItems(),
                                value: dersHarfDegeri,
                                onChanged: (value) {
                                  setState(() {
                                    dersHarfDegeri = value;
                                  });
                                }),
                          ),
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: tumDersler.length == 0
                                ? "Lutfen ders ekleyin"
                                : "Ortalama ",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                        TextSpan(
                            text: tumDersler.length == 0
                                ? " "
                                : "${ortalama.toStringAsPrecision(2)}",
                            style: TextStyle(fontSize: 18, color: Colors.black))
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )),
            Expanded(
              child: Container(
                  //color: Colors.green.shade200,
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return buildList(context, index);
                },
                itemCount: tumDersler.length,
              )),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredirediItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem(child: Text("$i Kredi"), value: i));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegeriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(" AA "),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" BA "),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" BB "),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" CB "),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" CC "),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" DC "),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" DD "),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" FF "),
      value: 0,
    ));
    return harfler;
  }

  void ortalamaHesapla() {
    double notToplam = 0;
    double krediToplam = 0;
    for (var ders in tumDersler) {
      var kredi = ders.kredi;
      var not = ders.harfDegeri;

      notToplam = notToplam + (kredi * not);
      krediToplam = krediToplam + kredi;
    }

    ortalama = notToplam / krediToplam;
  }

  Widget buildList(BuildContext context, int index) {
    sayac++;

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (value) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Card(
        color: tumDersler[index].renk,
        child: ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.white,
            ),
            title: Text(
              tumDersler[index].ad,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Ders Kredi: " +
                  tumDersler[index].kredi.toString() +
                  " " +
                  "Harf Degeri: " +
                  tumDersler[index].harfDegeri.toString(),
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.delete)),
      ),
    );
  }

  Color rastgeleRenk() {
    return Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}
