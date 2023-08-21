import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

import 'package:vstrecha/bloc/main_bloc.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final Function()? onBackAction;
  final String? actionText;
  final Widget? actionIcon;
  final Function()? onActionTap;
  final bool headerPadding;
  final bool? disableBack;

  const PageHeader({
    super.key,
    required this.title,
    this.onBackAction,
    this.actionText,
    this.actionIcon,
    this.onActionTap,
    this.headerPadding = true,
    this.disableBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: headerPadding ? MediaQuery.of(context).size.width * 0.32 : 40,
        bottom: 24,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SelectableAutoLinkText(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          disableBack == true
              ? Container()
              : Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: onBackAction ??
                        () {
                          MainBloc bloc = BlocProvider.of<MainBloc>(context);
                          bloc.add(PopPageEvent());
                        },
                    behavior: HitTestBehavior.opaque,
                    child: SvgPicture.asset('assets/icons/back_arrow.svg'),
                  ),
                ),
          actionText != null
              ? Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: onActionTap,
                    child: SelectableAutoLinkText(
                      actionText!,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : Container(),
          actionIcon != null
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onActionTap,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: actionIcon,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
