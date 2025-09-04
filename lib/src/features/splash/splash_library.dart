library;

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PACKAGE IMPORTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';
import 'package:sol_replace_revamp/src/core/constants/supabase.dart';
import 'package:sol_replace_revamp/src/core/globals/providers/user_provider.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';
import 'package:sol_replace_revamp/src/features/auth/auth_library.dart';
import 'package:sol_replace_revamp/src/features/auth/domain/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  PART FILES - ORGANIZED BY LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

//  PRESENTATION LAYER - VIEWS
part 'presentation/views/splash_view.dart';

//  PRESENTATION LAYER - VIEW MODELS
part 'presentation/viewmodels/splash_viewmodel.dart';

//  DATA LAYER - SOURCES
part 'data/data_source/remote/splash_data_source.dart';
part 'data/data_source/local/splash_data_source_locally.dart';

//  DATA LAYER - REPOSITORY IMPLEMENTATIONS
part 'data/repositories/splash_repository_impl.dart';

//  DOMAIN LAYER - REPOSITORY CONTRACTS
part 'domain/repositories/splash_repository.dart';
