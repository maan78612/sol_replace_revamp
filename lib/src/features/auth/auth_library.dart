library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PACKAGE IMPORTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sol_replace_revamp/src/core/components/custom_date_picker/date_picker_library.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';
import 'package:sol_replace_revamp/src/core/constants/images.dart';

import 'package:sol_replace_revamp/src/core/constants/supabase.dart';
import 'package:sol_replace_revamp/src/core/enums/auth_type.dart';
import 'package:sol_replace_revamp/src/core/enums/user_type.dart';
import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';
import 'package:sol_replace_revamp/src/core/utilities/dialog_box.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';
import 'package:sol_replace_revamp/src/features/auth/domain/model/user_model.dart';
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
import 'package:sol_replace_revamp/src/core/di/service_locator.dart';
import 'package:sol_replace_revamp/src/core/globals/text_field_validator.dart';
import 'package:sol_replace_revamp/src/core/enums/snackbar_status.dart';
import 'package:sol_replace_revamp/src/core/utilities/custom_snack_bar.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';
import 'package:sol_replace_revamp/src/features/otp/otp_library.dart';
import 'package:sol_replace_revamp/src/features/forget_password/forget_password_library.dart';

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

//  PRESENTATION LAYER - BLOC
part 'presentation/bloc/auth/auth_event.dart';

part 'presentation/bloc/auth/auth_state.dart';

part 'presentation/bloc/auth/auth_bloc.dart';

part 'presentation/bloc/login/login_event.dart';

part 'presentation/bloc/login/login_state.dart';

part 'presentation/bloc/login/login_bloc.dart';

part 'presentation/bloc/signup/signup_event.dart';

part 'presentation/bloc/signup/signup_state.dart';

part 'presentation/bloc/signup/signup_bloc.dart';

//  DATA LAYER - SOURCES
part 'data/data_source/remote/auth_data_source.dart';

part 'data/data_source/remote/forget_password_data_source.dart';

part 'data/data_source/local/auth_data_source_local.dart';

//  DATA LAYER - REPOSITORY IMPLEMENTATIONS
part 'data/repositories/auth_repository_impl.dart';

//  DOMAIN LAYER - REPOSITORY CONTRACTS
part 'domain/repositories/auth_repository.dart';
