part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _LoginComponent extends ConsumerWidget {
  _LoginComponent();

  final loginViewModelProvider = ChangeNotifierProvider<_LoginViewModel>((ref) {
    return _LoginViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loginViewModelProvider);

    return ResponsiveWidget(
      builder: (context, data) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 20.0,
                tablet: 24.0,
                desktop: 28.0,
              ),
            ),
            CustomInputField(
              hint: 'Email',
              title: 'Enter your email.',
              titleIcon: AppIcons.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: vm.emailCont,
              onChange: (value) => vm.onChange(
                con: vm.emailCont,
                value: value,
                validator: TextFieldValidator.validateEmail,
              ),
              suffixWidget: _getSuffixIcon(con: vm.emailCont, data: data),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 30.0,
                tablet: 36.0,
                desktop: 42.0,
              ),
            ),
            CustomInputField(
              title: 'Password',
              hint: 'Enter your password.',
              obscure: true,
              textInputAction: TextInputAction.done,
              controller: vm.passwordCont,
              onChange: (value) => vm.onChange(
                con: vm.passwordCont,
                value: value,
                validator: TextFieldValidator.validatePassword,
              ),
            ),

            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                  right: ResponsiveHelper.responsiveWidth(
                    data: data,
                    mobile: 4.0,
                    tablet: 6.0,
                    desktop: 8.0,
                  ),
                  top: ResponsiveHelper.responsiveHeight(
                    data: data,
                    mobile: 4.0,
                    tablet: 6.0,
                    desktop: 8.0,
                  ),
                  bottom: ResponsiveHelper.responsiveHeight(
                    data: data,
                    mobile: 4.0,
                    tablet: 6.0,
                    desktop: 8.0,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(
                      ResponsiveHelper.responsiveWidth(
                        data: data,
                        mobile: 8.0,
                        tablet: 10.0,
                        desktop: 12.0,
                      ),
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: FontStyles.montserratRegular.copyWith(
                        fontSize: ResponsiveHelper.adaptiveFontSize(
                          data: data,
                          baseSize: 12.0,
                          scaleFactor: 0.95,
                        ),
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 30.0,
                tablet: 36.0,
                desktop: 42.0,
              ),
            ),
            _guestText(data),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 10.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
            ),
            CustomButton(
              title: 'LOGIN',
              onPressed: () => vm.loginUser(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 10.0,
                tablet: 12.0,
                desktop: 14.0,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _getSuffixIcon({required CustomTextController con, required ResponsiveData data}) {
    return (con.controller.text.isNotEmpty)
        ? Icon(
            con.error != null ? Icons.close : Icons.check,
            color: con.error != null
                ? AppColors.redColor
                : AppColors.primaryColor,
            size: ResponsiveHelper.responsiveWidth(
              data: data,
              mobile: 18.0,
              tablet: 20.0,
              desktop: 22.0,
            ),
          )
        : null;
  }

  Widget _guestText(ResponsiveData data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveHelper.responsiveWidth(
            data: data,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
          ),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "To continue as a Guest. ",
            style: FontStyles.montserratRegular.copyWith(
              fontSize: ResponsiveHelper.adaptiveFontSize(
                data: data,
                baseSize: 14.0,
                scaleFactor: 0.95,
              ),
              color: AppColors.blackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Click Here',
                style: FontStyles.montserratRegular.copyWith(
                  fontSize: ResponsiveHelper.adaptiveFontSize(
                    data: data,
                    baseSize: 14.0,
                    scaleFactor: 0.95,
                  ),
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
