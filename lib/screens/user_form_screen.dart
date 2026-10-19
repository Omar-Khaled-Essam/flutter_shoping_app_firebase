import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'user_data_screen.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _hobbyController = TextEditingController();
  final _firestore = FirestoreService();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _hobbyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await _firestore.saveRecord(
        name: _nameController.text,
        age: int.parse(_ageController.text.trim()),
        favouriteHobby: _hobbyController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record saved to Firestore.')));
      _formKey.currentState!.reset();
      _nameController.clear();
      _ageController.clear();
      _hobbyController.clear();
    } catch (error) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not save record: $error')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('User information')),
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Card(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Save your information',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                      controller: _nameController,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: const InputDecoration(
                                          labelText: 'Name',
                                          prefixIcon:
                                              Icon(Icons.person_outline)),
                                      validator: (value) =>
                                          value == null || value.trim().isEmpty
                                              ? 'Enter your name.'
                                              : null),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Age',
                                          prefixIcon:
                                              Icon(Icons.cake_outlined)),
                                      validator: (value) {
                                        final age =
                                            int.tryParse(value?.trim() ?? '');
                                        if (age == null || age < 1 || age > 120)
                                          return 'Enter an age between 1 and 120.';
                                        return null;
                                      }),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                      controller: _hobbyController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: const InputDecoration(
                                          labelText: 'Favourite Hobby',
                                          prefixIcon:
                                              Icon(Icons.favorite_border)),
                                      validator: (value) =>
                                          value == null || value.trim().isEmpty
                                              ? 'Enter your favourite hobby.'
                                              : null),
                                  const SizedBox(height: 22),
                                  FilledButton(
                                      onPressed: _saving ? null : _save,
                                      child: _saving
                                          ? const CircularProgressIndicator()
                                          : const Text('Save to Firestore')),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  const UserDataScreen())),
                                      child: const Text('View saved records')),
                                ]),
                          ))),
                ))),
      );
}
