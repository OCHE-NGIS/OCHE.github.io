import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  late AnimationController _submitController;

  @override
  void initState() {
    super.initState();
    _submitController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _submitController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      _submitController.repeat();
      
      // Simulate form submission
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isSubmitting = false);
        _submitController.stop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Get in Touch",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ).animate().fadeIn().slideY(
                begin: 20,
                end: 0,
                curve: Curves.easeOut,
              ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                _SocialLinks().animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _AnimatedFormField(
                        label: 'Name',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _AnimatedFormField(
                        label: 'Email',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _AnimatedFormField(
                        label: 'Message',
                        maxLines: 5,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      _SubmitButton(
                        onPressed: _handleSubmit,
                        isSubmitting: _isSubmitting,
                        controller: _submitController,
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).slideY(
                        begin: 30,
                        end: 0,
                        delay: 400.ms,
                        curve: Curves.easeOut,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: Icons.business,
          url: 'https://linkedin.com/in/yourusername',
          label: 'LinkedIn',
        ),
        const SizedBox(width: 20),
        _SocialButton(
          icon: Icons.email,
          url: 'mailto:your.email@example.com',
          label: 'Email',
        ),
        const SizedBox(width: 20),
        _SocialButton(
          icon: Icons.mail,
          url: 'https://twitter.com/yourusername',
          label: 'X/Twitter',
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;

  const _SocialButton({
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // TODO: Launch URL
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered ? Colors.blue.shade700 : Colors.white,
            border: Border.all(
              color: _isHovered ? Colors.blue.shade700 : Colors.grey.shade300,
            ),
          ),
          child: AnimatedRotation(
            turns: _isHovered ? 0.1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              widget.icon,
              color: _isHovered ? Colors.white : Colors.blue.shade700,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedFormField extends StatefulWidget {
  final String label;
  final int maxLines;
  final String? Function(String?)? validator;

  const _AnimatedFormField({
    required this.label,
    this.maxLines = 1,
    this.validator,
  });

  @override
  State<_AnimatedFormField> createState() => _AnimatedFormFieldState();
}

class _AnimatedFormFieldState extends State<_AnimatedFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isFocused ? Colors.blue.shade700 : Colors.grey.shade300,
          width: _isFocused ? 2 : 1,
        ),
      ),
      child: TextFormField(
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: widget.validator,
        onChanged: (_) {},
        focusNode: FocusNode()..addListener(() {
          setState(() => _isFocused = FocusScope.of(context).hasFocus);
        }),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;
  final AnimationController controller;

  const _SubmitButton({
    required this.onPressed,
    required this.isSubmitting,
    required this.controller,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isSubmitting ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.blue.shade800 : Colors.blue.shade700,
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isSubmitting) ...[
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                widget.isSubmitting ? 'Sending...' : 'Send Message',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}