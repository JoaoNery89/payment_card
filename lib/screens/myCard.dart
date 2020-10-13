import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import '../constants/input_formatters.dart';
import '../constants/meusDados.dart';
import '../constants/utils.dart';

class MyCard extends StatefulWidget {
  MyCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  TextEditingController cardNumberController;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var numberController = TextEditingController();
  var nameController = TextEditingController();
  var validateDateController = TextEditingController();
  var cvvController = TextEditingController();
  var cepController = TextEditingController();

  var _autoValidate = false;

  var _paymentCard = PaymentCard();

  @override
  void initState() {
    cardNumberController = TextEditingController.fromValue(TextEditingValue(text: '0000 0000 0000 000'));
    nameController = TextEditingController();
    cvvController = TextEditingController();
    validateDateController = TextEditingController();
    cardNumberController.addListener(() {
      setState(() {
        cardNumberController = cardNumberController;
      });
    });

    _paymentCard.type = CardType.Others;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottom,),
        reverse: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0,12.0,12.0,0),
            child: Column(
              children: [
                Card( //Todo: Separar em um componente
                  shadowColor: Colors.lightBlue,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/cardBg.png',fit: BoxFit.fill,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:16.0),
                              child: Text(
                                "${cardNumberController.text}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Validade",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "${validateDateController.text}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:50),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "CVV",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.0
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "${cvvController.text}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "${nameController.text}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  elevation: 8.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16,),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12,),
                      child: Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Número do Cartão",
                                suffixIcon: Icon(
                                  Icons.credit_card,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: cardNumberController,
                              validator: CardUtils.validateCardNum,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(19),
                                CardNumberInputFormatter(),
                              ],
                              textCapitalization: TextCapitalization.characters,
                              onSaved: (String value) {
                                print('onSaved = $value');
                                print('Num controller has = ${cardNumberController.text}');
                                _paymentCard.number = CardUtils.getCleanedNumber(value);
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Validade do Cartão",
                                hintText: "MM//YY",
                              ),
                              controller: validateDateController,
                              validator: CardUtils.validateDate,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter()
                              ],
                              onSaved: (value) {
                                List<int> expiryDate = CardUtils.getExpiryDate(value);
                                _paymentCard.month = expiryDate[0];
                                _paymentCard.year = expiryDate[1];
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Código de Segurança",
                              ),
                              keyboardType: TextInputType.number,
                              validator: CardUtils.validateCVV,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              onSaved: (value){
                                _paymentCard.cvv = int.parse(value);
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Nome do Titular",
                                suffixIcon: Icon(
                                  Icons.person_outline
                                )
                              ),
                              controller: nameController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12,),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "CEP",
                              suffixIcon: Icon(
                                Icons.location_on,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: cepController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0,),
                    child: _getRegisterButton()
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cardNumberController.removeListener(_getCardTypeFrmNumber);
    cardNumberController.dispose();
    nameController.dispose();
    validateDateController.dispose();
    cvvController.dispose();
    cepController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true;
      });
      _showInSnackBar('Campos Vazio!');
    } else {
      form.save();
      _showInSnackBar('Cartão Inválido');
    }
  }

  Widget _getRegisterButton() {
    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          Strings.register,
          style: const TextStyle(fontSize: 17.0,),
        ),
      );
    } else {
      return RaisedButton(
        onPressed: _validateInputs,
        color: Colors.lightBlueAccent,
        splashColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(100.0,),),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0,),
        textColor: Colors.white,
        child: Text(
          Strings.register.toUpperCase(),
          style: const TextStyle(fontSize: 17.0,),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(value,),
        duration: Duration(seconds: 3,),
      ),
    );
  }

}