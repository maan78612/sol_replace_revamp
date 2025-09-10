library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PACKAGE IMPORTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:equatable/equatable.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/enums/snackbar_status.dart';
import 'package:sol_replace_revamp/src/core/utilities/custom_snack_bar.dart';
import 'package:sol_replace_revamp/src/core/di/service_locator.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PART FILES - ORGANIZED BY LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

//  PRESENTATION LAYER - VIEWS
part 'presentation/views/otp_view.dart';

//  PRESENTATION LAYER - BLOC
part 'presentation/bloc/otp/otp_event.dart';

part 'presentation/bloc/otp/otp_state.dart';

part 'presentation/bloc/otp/otp_bloc.dart';

//  DATA LAYER - SOURCES
part 'data/data_source/remote/otp_data_source.dart';

//  DATA LAYER - REPOSITORY IMPLEMENTATIONS
part 'data/repositories/otp_repository_impl.dart';

//  DOMAIN LAYER - REPOSITORY CONTRACTS
part 'domain/repositories/otp_repository.dart';
