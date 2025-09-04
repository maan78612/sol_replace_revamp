class TextFieldValidator {
  /// Validate Full Name with localized error messages
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    // Trim whitespace
    String trimmedValue = value.trim();

    // Check minimum length
    if (trimmedValue.length < 2) {
      return 'Full name must be at least 2 characters';
    }

    // Check maximum length
    if (trimmedValue.length > 100) {
      return 'Full name cannot exceed 100 characters';
    }

    // Check for at least one letter
    if (!RegExp(r'[a-zA-Z]').hasMatch(trimmedValue)) {
      return 'Full name is required';
    }

    // Check for invalid characters
    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(trimmedValue)) {
      return 'Full name can only contain letters, spaces, dots, apostrophes, and hyphens';
    }

    // Check for multiple consecutive spaces
    if (RegExp(r'\s{2,}').hasMatch(trimmedValue)) {
      return 'Full name cannot contain multiple consecutive spaces';
    }

    return null;
  }

  /// Validate Email with localized error messages
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Trim whitespace and convert to lowercase
    String cleanValue = value.trim().toLowerCase();

    // Check basic length
    if (cleanValue.length < 5) {
      return 'Please enter a valid email';
    }

    if (cleanValue.length > 254) {
      return 'Please enter a valid email';
    }

    // Enhanced email regex
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(cleanValue)) {
      return 'Please enter a valid email';
    }

    // Check for valid domain
    List<String> parts = cleanValue.split('@');
    if (parts.length != 2) {
      return 'Please enter a valid email';
    }

    String domain = parts[1];
    if (domain.startsWith('.') ||
        domain.endsWith('.') ||
        domain.contains('..')) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validate password with localized error messages
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  /// Validate confirm password with localized error messages
  static String? validateConfirmPassword(
    String? confirmPass,
    String? password,
  ) {
    if (confirmPass == null || confirmPass.isEmpty) {
      return 'Password is required';
    }

    if (confirmPass != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}
