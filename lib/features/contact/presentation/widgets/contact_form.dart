import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  static const String _recipientEmail = 'nzyhla227@gmail.com';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final uri = Uri(
      scheme: 'mailto',
      path: _recipientEmail,
      queryParameters: {
        'subject': 'Portfolio Contact - ${_nameController.text.trim()}',
        'body': '''
Name: ${_nameController.text.trim()}
Email: ${_emailController.text.trim()}

Message:
${_messageController.text.trim()}
''',
      },
    );

    try {
      final launched = await launchUrl(uri);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            launched
                ? 'Your email application has been opened.'
                : 'Could not open an email application. '
                    'Please email me directly.',
          ),
        ),
      );
    } catch (error) {
      debugPrint('Could not open email: $error');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(context, 'Name'),
          const SizedBox(height: 10),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: _inputDecoration(
              context,
              hint: 'Your name',
              icon: Icons.person_outline,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name.';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),

          _buildFieldLabel(context, 'Email'),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
              context,
              hint: 'your@email.com',
              icon: Icons.email_outlined,
            ),
            validator: (value) {
              final email = value?.trim() ?? '';

              if (email.isEmpty) {
                return 'Please enter your email.';
              }

              final emailRegex = RegExp(
                r"^[\w.!#$%&’*+/=?^_`{|}~-]+@"
                r"[\w-]+(\.[\w-]+)+$",
              );

              if (!emailRegex.hasMatch(email)) {
                return 'Please enter a valid email address.';
              }

              return null;
            },
          ),
          const SizedBox(height: 28),

          _buildFieldLabel(context, 'Message'),
          const SizedBox(height: 10),
          TextFormField(
            controller: _messageController,
            minLines: 5,
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            decoration: _inputDecoration(
              context,
              hint: 'Tell me about your project...',
              icon: Icons.message_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your message.';
              }

              if (value.trim().length < 10) {
                return 'Message must be at least 10 characters.';
              }

              return null;
            },
          ),
          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _isSubmitting ? null : _sendMessage,
              icon: _isSubmitting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.onPrimary,
                      ),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(
                _isSubmitting ? 'Opening Email...' : 'Send Message',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      label,
      style: TextStyle(
        color: colors.onSurface.withValues(alpha: 0.85),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final borderRadius = BorderRadius.circular(14);

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: colors.onSurface.withValues(alpha: 0.45),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: colors.onSurface.withValues(alpha: 0.55),
        size: 20,
      ),
      filled: true,
      fillColor: colors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: colors.secondary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: colors.error,
          width: 1.5,
        ),
      ),
    );
  }
}