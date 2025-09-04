library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PACKAGE IMPORTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sol_replace_revamp/src/core/components/common_radio_widget.dart';
import 'package:sol_replace_revamp/src/core/components/custom_date_picker/date_picker_library.dart';
import 'package:sol_replace_revamp/src/core/components/loader.dart';
import 'package:sol_replace_revamp/src/core/constants/api_urls.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';
import 'package:sol_replace_revamp/src/core/constants/images.dart';
import 'package:sol_replace_revamp/src/core/constants/supabase.dart';
import 'package:sol_replace_revamp/src/core/enums/auth_type.dart';
import 'package:sol_replace_revamp/src/core/enums/user_type.dart';
import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';
import 'package:sol_replace_revamp/src/core/utilities/dialog_box.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';
import 'package:sol_replace_revamp/src/core/constants/supabase.dart';
import 'package:sol_replace_revamp/src/core/services/supabase/exceptions.dart';
import 'package:sol_replace_revamp/src/features/auth/domain/model/user_model.dart';
import 'package:sol_replace_revamp/src/features/otp/data/data_source/remote/otp_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  CORE COMPONENTS & UTILITIES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/components/custom_input_field.dart';
import 'package:sol_replace_revamp/src/core/components/custom_text_controller.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/globals/text_field_validator.dart';
import 'package:sol_replace_revamp/src/core/enums/snackbar_status.dart';
import 'package:sol_replace_revamp/src/core/utilities/custom_snack_bar.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PART FILES - ORGANIZED BY LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

//  PRESENTATION LAYER - VIEWS

part 'presentation/views/auth_view.dart';

part 'presentation/views/components/login.dart';

part 'presentation/views/components/signup/signup.dart';

part 'presentation/views/components/signup/components/password_form.dart';
part 'presentation/views/components/signup/components/dob.dart';

part 'presentation/views/components/authentication_switcher.dart';

part 'presentation/views/components/social_auth.dart';

//  PRESENTATION LAYER - VIEW MODELS
part 'presentation/viewmodels/login_viewmodel.dart';

part 'presentation/viewmodels/signup_viewmodel.dart';

part 'presentation/viewmodels/auth_vm.dart';

//  DATA LAYER - SOURCES
part 'data/data_source/remote/auth_data_source.dart';

part 'data/data_source/local/auth_data_source_local.dart';

//  DATA LAYER - REPOSITORY IMPLEMENTATIONS
part 'data/repositories/auth_repository_impl.dart';

//  DOMAIN LAYER - REPOSITORY CONTRACTS
part 'domain/repositories/auth_repository.dart';
