import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';
import 'package:live_football_scrolling_poc/widgets/team_logo_name.dart';

class FixtureDetailsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                'April 11, 2021',
                style: TextStyles.regular14.copyWith(color: AppColors.textLightGray),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '10:00 PM',
                style: TextStyles.regular16.copyWith(color: AppColors.textLightGray),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TeamLogoAndName(
                    teamName: 'Real Madrid',
                    teamLogo: 'icons/realmadrid.png',
                    backgroundColor: Colors.white,
                    strokeColor: AppColors.darkWhite,
                    strokeWidth: 4.0,
                    textStyle: TextStyles.semiBold15.copyWith(color: AppColors.textDarkGray),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16 * 2.0),
                  child: Text(
                    '2 - 1',
                    style: TextStyles.semiBold50,
                  ),
                ),
                Expanded(
                  child: TeamLogoAndName(
                    teamName: 'Barcelona',
                    teamLogo: 'icons/barcelona.png',
                    backgroundColor: Colors.white,
                    strokeColor: AppColors.darkWhite,
                    strokeWidth: 4.0,
                    textStyle: TextStyles.semiBold15.copyWith(color: AppColors.textDarkGray),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('FT', style: TextStyles.semiBold16),
            ),
          ],
        ),
      ),
    );
  }
}
