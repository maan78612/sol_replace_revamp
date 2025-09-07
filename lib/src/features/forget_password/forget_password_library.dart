library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PACKAGE IMPORTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:equatable/equatable.dart';
import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/components/custom_input_field.dart';
import 'package:sol_replace_revamp/src/core/components/custom_text_controller.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';
import 'package:sol_replace_revamp/src/core/di/service_locator.dart';
import 'package:sol_replace_revamp/src/core/globals/text_field_validator.dart';
import 'package:sol_replace_revamp/src/core/enums/snackbar_status.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';
import 'package:sol_replace_revamp/src/core/utilities/custom_snack_bar.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';
import 'package:sol_replace_revamp/src/features/auth/auth_library.dart';
import 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PART FILES - ORGANIZED BY LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

//  PRESENTATION LAYER - VIEWS
part 'presentation/views/send_email_view.dart';

//  PRESENTATION LAYER - BLOC
part 'presentation/bloc/send_email/send_email_event.dart';
part 'presentation/bloc/send_email/send_email_state.dart';
part 'presentation/bloc/send_email/send_email_bloc.dart';
