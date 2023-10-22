import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prueba_abalit/home_page.dart';
import 'register_page.dart';
import 'dataClasses/user.dart';
import 'fToastItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestingFlutter2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const Login(
        usersList: [],
      ),
    );
  }
}

///Página con el login
class Login extends StatefulWidget {
  const Login({super.key, required this.usersList});

  final List<User> usersList;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: 150,
                height: 150,
                margin: const EdgeInsets.all(100),
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
                  "¡Hola de nuevo!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
                decoration: const InputDecoration(
                    hintText: "Introduce correo electrónico",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                obscureText: true,
                controller: passwdController,
                decoration: const InputDecoration(
                    hintText: "Introduce contraseña",
                    border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("He olvidado mi contraseña. "),
                GestureDetector(
                  onTap: null,
                  child: const Text(
                    "Recuperar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: checkingMailAndPasswd,
                  child: const Text("LOG IN")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage(
                                  usersList: widget.usersList,
                                )));
                  },
                  child: const Text(
                    "¡Registrarse!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///Chequea el mail y el password para dar acceso a la app
  void checkingMailAndPasswd() {
    int? index;

    index = checkingMail();

    if (index != null) {
      checkingPasswdAndLogin(index);
    }

    mailController.clear();
    passwdController.clear();
  }

  ///Chequea si existe o no el mail en la lista de usuarios
  int? checkingMail() {
    int? index;

    for (int i = 0; i < widget.usersList.length; i++) {
      index = mailController.text.toLowerCase() ==
              widget.usersList[i].mail.toLowerCase()
          ? i
          : null;
    }
    if (index == null) {
      showError("La dirección email no está registrada en la aplicación.");
    }

    return index;
  }

  ///chequea si el password se corresponde con el del usuario y redirige a la app
  void checkingPasswdAndLogin(int index) {
    if (passwdController.text == widget.usersList[index].passwd) {
      goingToHomePage(widget.usersList[index]);
    } else {
      showError("Has introducido mal o no has introducido la contraseña");
    }
  }

  ///Redirige a la página principal de la app
  void goingToHomePage(User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  title: "Logo",
                  user: user,
                )));
  }

  ///Muestra un FToast con el error que se le pasa por parámetro
  void showError(String message) {
    fToast.showToast(
        child: FToastItem(
          msg: message,
          color: Colors.red,
        ),
        toastDuration: const Duration(seconds: 2));
  }
}
