import 'package:flutter/material.dart';
import '../../../core/utils/validators.dart';

class AuthForm extends StatefulWidget {
  final String buttonText;
  final void Function(String email, String password) onSubmit;
  final bool isLoading;

  const AuthForm({
    super.key,
    required this.buttonText,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.onSubmit(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
            onSaved: (val) => _email = val ?? '',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: Validators.validatePassword,
            onSaved: (val) => _password = val ?? '',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.isLoading ? null : _submit,
            child: widget.isLoading
                ? const CircularProgressIndicator()
                : Text(widget.buttonText),
          ),
        ],
      ),
    );
  }
} 