import 'package:flutter/material.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';
import 'package:validations/validations.dart';

part 'signin_form.g.dart';

class SignInData {
  @Size(
    min: 2,
    max: 255,
  )
  String name;

  @Email()
  @NotEmpty()
  String email;

  @NotEmpty()
  @Size(
    min: 2,
    max: 20,
    message: r'password length must be between $min and $max',
  )
  String password;
}

@GenValidator()
class SignInDataValidator extends Validator<SignInData>
    with _$SignInDataValidator {}

class SignInForm extends StatefulWidget {
  final String error;
  SignInForm({this.error});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = SignInData();
  // CustomerBloc _customerBloc;
  SignInDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = SignInDataValidator();

    // _customerBloc = BlocProvider.of<CustomerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (widget.error != null)
            ErrorContainer(
              error: widget.error,
            ),
          const SizedBox(height: 16),
          createTextField(
            // focusNode: _emailFocus,
            hintText: 'Email',
            autovalidate: false,
            validator: _validator.validateEmail,
            onSaved: (String value) {
              setState(() {
                _data.email = value;
              });
            },
          ),
          const SizedBox(height: 16),
          createTextField(
            hintText: 'Password',
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.password = value;
            },
            validator: _validator.validatePassword,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: 'Sign In',
              onPressed: _signIn,
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      /*
      _customerBloc.dispatch(
        SignIn(
          name: _data.name,
          email: _data.email,
          password: _data.password,
        ),
      );
       */

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: const Text('Processing Data')));
    }
  }
}