import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/r.dart';
import 'package:new_movie_flutter/screen/auth/login/login_view.dart';
import 'package:new_movie_flutter/screen/auth/register/register_view.dart';
import 'package:new_movie_flutter/splash_controller.dart';
import 'package:new_movie_flutter/util/constant.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    void _loginSheet(context) {
      showBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
            emailController: controller.emailController,
            passwordController: controller.passwordController,
          );
        },
      );
    }

    void _registerSheet(context) {
      showBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
            emailController: controller.emailController,
            passwordController: controller.passwordController,
            nameController: controller.nameController,
          );
        },
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Builder(builder: (context) {
          return Stack(children: [
            Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(R.images_splashscreen),
                        fit: BoxFit.fill))),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: controller.isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          label: "MASUK",
                          primaryColor: Colors.white,
                          secondaryColor: Colors.black,
                          onPressed: () => _loginSheet(context),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          label: "DAFTAR",
                          primaryColor: Colors.transparent,
                          secondaryColor: Colors.white,
                          onPressed: () => _registerSheet(context),
                        ),
                      ],
                    ),
            ),
          ]);
        }));
  }
}

class CustomButton extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  final String label;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    @required required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        highlightElevation: 0.0,
        splashColor: secondaryColor,
        highlightColor: primaryColor,
        elevation: 0.0,
        color: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: const BorderSide(color: Colors.white, width: 3)),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 20),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool? obsecure;

  const CustomTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.obsecure,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecure ?? false,
      style: const TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: icon,
            ),
          )),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    TextEditingController? nameController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _nameController = nameController,
        super(key: key);

  final TextEditingController? _emailController;
  final TextEditingController? _passwordController;
  final TextEditingController? _nameController;

  List<Widget> get _registerLogo => [
        Positioned(
          child: Container(
            padding: const EdgeInsets.only(bottom: 25, right: 40),
            alignment: Alignment.center,
            child: const Text(
              "REGI",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 40, left: 28),
              width: 130,
              child: const Text(
                "STER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 38),
              ),
            ),
          ),
        ),
      ];

  List<Widget> get _loginLogo => [
        Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: const Color(0xff634D43)),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _emailController?.clear();
                          _passwordController?.clear();
                          _nameController?.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30.0,
                          color: Color(0xff634D43),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xff634D43)),
                              ),
                            ),
                            ..._nameController != null
                                ? _registerLogo
                                : _loginLogo
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      if (_nameController != null)
                        RegisterView()
                      else
                        LoginView()
                    ],
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
