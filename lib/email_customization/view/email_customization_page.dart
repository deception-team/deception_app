// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:deception_app/app/deception_colors.dart';
import 'package:deception_app/email_customization/use_case/update_email_use_case.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deception_app/email_customization/email_customization.dart';
import 'package:deception_app/l10n/l10n.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EmailCustomizationPage extends StatelessWidget {
  const EmailCustomizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(),
    );
  }
}

String deceptionEmail = '';
String privateEmail = '';
UpdateEmailController updateEmailUseCase = UpdateEmailController(
    updateEmailUseCase:
        UpdateEmailUseCase(CloudflareApi('7a452090b40b4d55e60bf6c4e28144b4')),
    userId: UserId('placeholderId'));

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'xXMustermannXx',
                    style: GoogleFonts.raleway(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 20),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Deine E-Mail-Adressen',
                  style: GoogleFonts.raleway(
                    textStyle: Theme.of(context).textTheme.headline2!,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 80),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailTextField(),
                  // Opacity(opacity: 0.3, child: EmailTextField()),
                  const SizedBox(height: 50),
                  PersonalEmailTextField(),
                ],
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    await updateEmailUseCase.updateEmails(
                      privateEmail: privateEmail,
                      deceptionEmail: deceptionEmail,
                    );
                  },
                  child: Text(
                    'AB GEHTS',
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: AutoSizeTextField(
            maxLength: 20,
            decoration: InputDecoration(
              focusColor: Colors.white,
              fillColor: Colors.white,
              hoverColor: Colors.white,
            ),
            minWidth: 50,
            fullwidth: false,
            textAlign: TextAlign.end,
            controller: TextEditingController(),
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            onChanged: (newCustomPart) {
              deceptionEmail = '$newCustomPart@deception.team';
            },
          ),
        ),
        Flexible(
            flex: 2,
            child: Text(
              '@deception.team',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            )),
      ],
    );
  }
}

class PersonalEmailTextField extends StatelessWidget {
  const PersonalEmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Private E-Mail',
          hintText: 'max-mustermann@gmail.com',
          focusColor: Colors.white,
          fillColor: Colors.white,
          hoverColor: Colors.white,
        ),
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
        onChanged: (newPrivateEmail) {
          privateEmail = newPrivateEmail;
        },
      ),
    );
  }
}
