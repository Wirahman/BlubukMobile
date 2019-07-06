import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final Color textFieldColor, iconColor;
  final bool obscureText;
  final  validateFunction;
  final  onSaved;

  final String onEmpty;
  final String name;

  //passing props in the Constructor.
  //Java like style
  InputField({
    this.name,
    this.hintText,
    this.onEmpty,
    this.obscureText,
    this.textInputType,
    this.textFieldColor,
    this.iconColor,
    this.icon,
    this.validateFunction,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) => (new Container(
      margin: new EdgeInsets.only(bottom: 10.0),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            color: Colors.grey[50]),
        child: new Padding(
          padding: EdgeInsets.all(5.0),
          child: new TextFormField(
            decoration: new InputDecoration(
              icon: new Icon(icon),
              labelText: name,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            validator: (val) => val.isEmpty ? onEmpty : null,
            onSaved: (val) => onSaved,
            obscureText: obscureText,
            keyboardType: textInputType,
          ),
        ),
      ),
    ));
}

class TextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;

  //passing props in the Constructor.
  //Java like style
  TextButton({
    this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => (new FlatButton(
      child: new Text(name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold)),
      onPressed: onPressed,
    ));
}
