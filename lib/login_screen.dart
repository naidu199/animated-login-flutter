import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
// import 'package:rive_common/layout_engine.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final animationlink = 'login_animated.riv';
  bool isPassword = true;

  Artboard? artboard;
  StateMachineController? stateMachineController;
  late SMITrigger failtrigger, successtrigger;
  late SMIBool lookbool, closebool;
  late SMINumber numlook;

  @override
  void initState() {
    super.initState();
    initArtBorad();
  }

  void initArtBorad() async {
    try {
      final riveFile = await RiveFile.asset(animationlink);

      final art = riveFile.mainArtboard;

      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine")!;
      if (stateMachineController != null) {
        art.addController(stateMachineController!);
      }
      stateMachineController!.inputs.forEach((element) {
        if (element.name == 'trigSuccess') {
          successtrigger = element as SMITrigger;
        }
        if (element.name == 'trigFail') {
          failtrigger = element as SMITrigger;
        }
        if (element.name == 'isChecking') {
          lookbool = element as SMIBool;
        }
        if (element.name == 'isHandsUp') {
          closebool = element as SMIBool;
        }
        if (element.name == 'numLook') {
          numlook = element as SMINumber;
        }
      });
      setState(() {
        artboard = art;
      });
    } catch (e) {
      print(e);
    }
  }

  void handsOnEye() {
    lookbool.change(false);
    closebool.change(true);
  }

  void checking() {
    closebool.change(false);
    lookbool.change(true);
  }

  void movieEyeBalls(val) {
    numlook.change(val.length.toDouble());
  }

  void login() {
    lookbool.change(false);
    closebool.change(false);
    if (emailController.text == 'narasimhanaidu1909@gmail.com' &&
        passwordController.text == 'naidu@1909') {
      successtrigger.fire();
    } else {
      failtrigger.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //art board
            artboard != null
                ? Container(
                    color: Colors.black,
                    width: 450,
                    height: 300,
                    child: Rive(artboard: artboard!),
                  )
                : const SizedBox(),
            Container(
              alignment: Alignment.center,
              width: 450,
              padding: const EdgeInsets.all(4),
              // margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    onTap: checking,
                    onChanged: movieEyeBalls,
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email/Username",
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onTap: handsOnEye,
                    obscureText: isPassword,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                          gapPadding: 2,
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                            isPassword ? handsOnEye() : checking();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                      onTap: login,
                      borderRadius: BorderRadius.circular(15),
                      splashColor: Colors.white,
                      child: Container(
                        // margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent[200],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white)),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
