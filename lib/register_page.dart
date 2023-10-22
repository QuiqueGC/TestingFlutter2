import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba_abalit/dataClasses/user.dart';
import 'package:prueba_abalit/main.dart';

import 'fToastItem.dart';

///Página para el registro del usuario
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.usersList});

  final List<User> usersList;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FToast fToast = FToast();
  List<User> newUsersList = [];

  @override
  void initState() {
    super.initState();
    fToast.init(context);

    for (User u in widget.usersList) {
      newUsersList.add(u);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.all(80),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.green)),
                  child: const Text(
                    "L",
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                  width: double.maxFinite,
                  child: const Text(
                    "¡Te damos la bienvenida!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Introduce nombre y apellidos",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: "Introduce teléfono",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                  decoration: const InputDecoration(
                      hintText: "Introduce correo electrónico",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  controller: passwdController,
                  decoration: const InputDecoration(
                      hintText: "Introduce contraseña",
                      border: OutlineInputBorder()),
                ),
              ),
              const Text("Acepto la política de privacidad."),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: creatingNewUser, child: const Text("SIGN IN")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///crea un nuevo usuario con los datos introducidos
  void creatingNewUser() {
    String? name, mail, passwd;
    int? phone;

    name = checkingTextInTheBox(
        "No has introducido ningún nombre de usuario", nameController);
    mail =
        checkingTextInTheBox("No has introducido ningún email", mailController);
    passwd = checkingTextInTheBox(
        "No has introducido un password", passwdController);
    phone = checkingPhoneNumber();

    bool correctData =
        name != null && mail != null && passwd != null && phone != null;

    if (correctData) {
      User user = User(mail, passwd, name, phone);
      newUsersList.add(user);

      turningBackToLogin();

      showCorrectRegisterToast(
          "Te has registrado correctamente!", Colors.green);
    } else {
      showError("El usuario no ha podido crearse");
    }

    mailController.clear();
    nameController.clear();
    passwdController.clear();
    phoneController.clear();
  }

  ///chequea que el campo no está vacío
  String? checkingTextInTheBox(
      String errorMsg, TextEditingController controller) {
    if (controller.text != "") {
      return controller.text;
    } else {
      showError(errorMsg);

      return null;
    }
  }

  ///Chequea que el dato introducido es un int
  int? checkingPhoneNumber() {
    int? phone;

    if (phoneController.text != "") {
      try {
        phone = int.parse(phoneController.text);
      } catch (e) {
        phone = null;

        showError("No has introducido el número de teléfono correctamente");
      }

      return phone;
    } else {
      return null;
    }
  }

  ///Devuelve a la página del login
  void turningBackToLogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                  usersList: newUsersList,
                )));
  }

  ///Mensaje que avisa al usuario de que la operación ha sido correcta
  void showCorrectRegisterToast(String message, MaterialColor color) {
    fToast.showToast(
        child: FToastItem(
          msg: message,
          color: color,
        ),
        toastDuration: const Duration(seconds: 2));
  }

  ///Mensaje que avisa al usuario de que ha habido algún error en el procedimiento
  void showError(String message) {
    fToast.showToast(
        child: FToastItem(
          msg: message,
          color: Colors.red,
        ),
        toastDuration: const Duration(seconds: 2));
  }
}
