import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_ai_24/screens/saved_details.dart';
import '../components/profile_card.dart';
import '../providers/auth_provider.dart';
import '../providers/supabase_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedAge;
  bool _isLoading = false;

  final List<String> _ageOptions =
      List.generate(83, (index) => (index + 18).toString());

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final user = ref.read(authStateProvider).value;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in first')),
        );
      }
      return;
    }

    try {
      await ref.read(databaseServiceProvider).saveUserDetails(
            userId: user.uid,
            address: _addressController.text,
            phone: _phoneController.text,
            age: _selectedAge!,
            notes: _notesController.text,
          );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SavedDetails()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => Scaffold(
        body: Container(
          decoration: _buildBackgroundGradient(),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          flexibleSpace: _buildAppBarGradient(),
        ),
        body: Container(
          decoration: _buildBackgroundGradient(),
          child: Center(child: Text('Error: $error')),
        ),
      ),
      data: (user) {
        if (user == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sign In Required'),
              flexibleSpace: _buildAppBarGradient(),
            ),
            body: Container(
              decoration: _buildBackgroundGradient(),
              child: Center(
                child: ElevatedButton(
                  onPressed: () =>
                      ref.read(authServiceProvider).signInWithGoogle(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            centerTitle: true,
            flexibleSpace: _buildAppBarGradient(),
            elevation: 0,
          ),
          body: Container(
            decoration: _buildBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileCard(user: user),
                      const SizedBox(height: 24),
                      _buildFormCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Address Field
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.home),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your address' : null,
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            // Phone Field
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.phone),
                prefixText: '+',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^[0-9]{8,15}$').hasMatch(value)) {
                  return 'Enter 8-15 digits only';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Age Dropdown
            DropdownButtonFormField<String>(
              value: _selectedAge,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.cake),
              ),
              items: _ageOptions
                  .map((age) => DropdownMenuItem(
                        value: age,
                        child: Text('$age years'),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedAge = value),
              validator: (value) =>
                  value == null ? 'Please select your age' : null,
            ),
            const SizedBox(height: 20),

            // Notes Field
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Additional Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue.shade700,
                  disabledBackgroundColor: Colors.blue.shade400,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'SAVE PROFILE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildAppBarGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade50,
          Colors.blue.shade100,
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.3, 0.7],
      ),
    );
  }
}
