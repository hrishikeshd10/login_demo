import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';//we dont need thisimport as auth.dart is already using that import 
import 'auth.dart';

class LoginPage extends StatefulWidget {


LoginPage({this.auth});
final BaseAuth auth; 


  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {



  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Email: $_email, Password: $_password');
      return true;
    } else {
      print('form is invalid');
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {

          String userId = await widget.auth.SignInWithEmailAndPassword(_email, _password);
          //FirebaseUser user = await FirebaseAuth.instance
             // .signInWithEmailAndPassword(email: _email, password: _password);
          print('Signed In: ${userId}');
        }else{

            String userId = await widget.auth.CreateUserWithEmailAndPassword(_email, _password);

      //    FirebaseUser  user =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password);
         print('Registerd User: ${userId}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Campus Buddy  ')),
      body: new Container(
          child: new Form(
        key: formKey,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildInputs() + buildButtons(),
        ),
      )),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => !value.contains('@') ? 'Invalid Email' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.length < 6 ? 'Password is short' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login'),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Register',
            style: new TextStyle(fontSize: 20.00),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text('Create an Account'),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Already have an account?',
            style: new TextStyle(fontSize: 20.00),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
