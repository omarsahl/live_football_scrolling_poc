import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';
import 'package:live_football_scrolling_poc/data/parsed_team_lineup.dart';
import 'package:live_football_scrolling_poc/widgets/one_line_text.dart';
import 'package:live_football_scrolling_poc/widgets/simple_player_avatar.dart';

const Color _bgColor = const Color(0xFF01935C);
const Color _fgColor = const Color(0xFF1B9E6D);
const Radius _cornerRadius = const Radius.circular(8.0);
const double _strokeWidth = 5.0;
final TextStyle _playerNameStyle = TextStyles.regular12.copyWith(color: Colors.white);
final TextStyle _playerNumberStyle = TextStyles.bold12.copyWith(color: Colors.white.withOpacity(0.9));

class _CenterLinePainter extends CustomPainter {
  final _paint = Paint();
  final bool _mirror;

  _CenterLinePainter(this._mirror);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(-1, -1, size.width + 1, size.height + 1),
      _paint
        ..style = PaintingStyle.fill
        ..color = _bgColor,
    );

    Offset lineStart = Offset(0, _mirror ? 0 : size.height);
    canvas.drawLine(
      lineStart,
      lineStart.translate(size.width, 0),
      _paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..color = _fgColor,
    );

    final halfWidth = size.width * 0.5;
    final circleCenter = lineStart.translate(halfWidth, 0);
    final circleRadius = min(size.height * 2.0, 120.0) - _strokeWidth * 2.0;

    canvas.drawArc(
      Rect.fromCenter(center: circleCenter, width: circleRadius, height: circleRadius),
      pi,
      pi * (_mirror ? -1 : 1),
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _NonCenterLinePainter extends CustomPainter {
  final _paint = Paint()
    ..style = PaintingStyle.fill
    ..color = _bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(-1, -1, size.width + 1, size.height + 1), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _GoalkeeperPainter extends CustomPainter {
  final _paint = Paint();
  final bool _mirror;

  _GoalkeeperPainter(this._mirror);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      _paint
        ..style = PaintingStyle.fill
        ..color = _bgColor,
    );

    final largeRectHeight = size.height * 0.8;
    final smallRectHeight = size.height * 0.4;
    final halfWidth = size.width * 0.5;

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        halfWidth - halfWidth * 0.5,
        getAdjustedTop(size, largeRectHeight),
        halfWidth + halfWidth * 0.5,
        getAdjustedBottom(size, largeRectHeight),
        bottomLeft: _mirror ? Radius.zero : _cornerRadius,
        bottomRight: _mirror ? Radius.zero : _cornerRadius,
        topLeft: _mirror ? _cornerRadius : Radius.zero,
        topRight: _mirror ? _cornerRadius : Radius.zero,
      ),
      _paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..color = _fgColor,
    );

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        halfWidth - halfWidth * 0.25,
        getAdjustedTop(size, smallRectHeight),
        halfWidth + halfWidth * 0.25,
        getAdjustedBottom(size, smallRectHeight),
        bottomLeft: _mirror ? Radius.zero : _cornerRadius,
        bottomRight: _mirror ? Radius.zero : _cornerRadius,
        topLeft: _mirror ? _cornerRadius : Radius.zero,
        topRight: _mirror ? _cornerRadius : Radius.zero,
      ),
      _paint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(halfWidth, _mirror ? size.height - largeRectHeight : largeRectHeight),
        height: (size.height - largeRectHeight - _strokeWidth) * 2.0,
        width: halfWidth * 0.4,
      ),
      pi,
      pi * (_mirror ? 1 : -1),
      false,
      _paint,
    );
  }

  double getAdjustedTop(Size size, double height) {
    return _mirror ? size.height - height : 0;
  }

  double getAdjustedBottom(Size size, double height) {
    return _mirror ? size.height : height;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _GoalKeeperLine extends StatelessWidget {
  final bool _isLocal;
  final LineupItem _lineupItem;

  _GoalKeeperLine(ParsedTeamLineupLine line, this._isLocal)
      : assert(line.items.length == 1),
        _lineupItem = line.items.first;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: _isLocal ? Alignment.topCenter : Alignment.bottomCenter,
      children: [
        CustomPaint(painter: _GoalkeeperPainter(!_isLocal), size: const Size.fromHeight(130.0)),
        Padding(
          child: _PlayerAvatar(_lineupItem),
          padding: _isLocal ? const EdgeInsets.only(top: 24.0) : const EdgeInsets.only(bottom: 24.0),
        ),
      ],
    );
  }
}

class _CenterLine extends StatelessWidget {
  final bool _isLocal;
  final ParsedTeamLineupLine _line;

  _CenterLine(this._line, this._isLocal);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(painter: _CenterLinePainter(!_isLocal), size: const Size.fromHeight(100.0)),
        Row(
          children: _line.items.map((e) => Expanded(child: _PlayerAvatar(e))).toList(),
        ),
      ],
    );
  }
}

class _NonCenterLine extends StatelessWidget {
  final bool _isLocal;
  final ParsedTeamLineupLine _line;

  _NonCenterLine(this._line, this._isLocal);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(painter: _NonCenterLinePainter(), size: const Size.fromHeight(100.0)),
        Row(
          children: _line.items.map((e) => Expanded(child: _PlayerAvatar(e))).toList(),
        ),
      ],
    );
  }
}

class _PlayerAvatarRating extends StatelessWidget {
  final double _rating;

  _PlayerAvatarRating(this._rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
      decoration: ShapeDecoration(color: _ratingColor(), shape: StadiumBorder()),
      child: Text('${_rating.toStringAsPrecision(2)}', style: TextStyles.bold10.copyWith(color: Colors.white)),
    );
  }

  Color _ratingColor() {
    if (_rating >= 7.0) return Colors.green;
    if (_rating >= 5.0) return Colors.orange;
    return Colors.red;
  }
}

class _PlayerAvatarGoal extends StatelessWidget {
  const _PlayerAvatarGoal();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      child: Image.asset('icons/ic_football.png'),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: Colors.black38)],
      ),
    );
  }
}

class _CaptainBadge extends StatelessWidget {
  const _CaptainBadge();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CaptainBadgePainter(),
      size: const Size(10.0, 10.0),
    );
  }
}

class _CaptainBadgePainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(2.0)), _paint);
    final textPainter = TextPainter(
      text: TextSpan(text: 'C', style: TextStyles.bold8.copyWith(color: Colors.black)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) * 0.5, (size.height - textPainter.height) * 0.5),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _PlayerAvatar extends StatelessWidget {
  final LineupItem _lineupItem;

  _PlayerAvatar(this._lineupItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiChildLayout(
          delegate: _PlayerAvatarLayoutDelegate(22.0),
          children: [
            LayoutId(id: _Ids.avatar, child: SimplePlayerAvatar(_lineupItem.image)),
            LayoutId(id: _Ids.rating, child: _PlayerAvatarRating(_lineupItem.rating)),
            if (_lineupItem.scored) LayoutId(id: _Ids.goal, child: _PlayerAvatarGoal()),
          ],
        ),
        const SizedBox(height: 3.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_lineupItem.captain) ...[const _CaptainBadge(), const SizedBox(width: 4.0)],
                Text('${_lineupItem.number}', style: _playerNumberStyle),
              ],
            ),
            OneLineText(
              style: _playerNameStyle,
              text: '${_lineupItem.playerName}',
            ),
          ],
        ),
      ],
    );
  }
}

enum _Ids { avatar, rating, goal }

class _PlayerAvatarLayoutDelegate extends MultiChildLayoutDelegate {
  final double radius;

  _PlayerAvatarLayoutDelegate(this.radius);

  @override
  Size getSize(BoxConstraints constraints) => Size(radius * 2.0, radius * 2.0);

  @override
  void performLayout(Size size) {
    if (hasChild(_Ids.avatar)) {
      layoutChild(_Ids.avatar, BoxConstraints.tight(size));
      positionChild(_Ids.avatar, Offset.zero);
    }

    if (hasChild(_Ids.rating)) {
      final width = layoutChild(_Ids.rating, BoxConstraints.tightFor()).width;
      positionChild(_Ids.rating, size.topRight(Offset(-width / 2.0, 0)));
    }

    if (hasChild(_Ids.goal)) {
      final width = layoutChild(_Ids.goal, BoxConstraints.tightFor(width: 15.0, height: 15.0)).width;
      positionChild(_Ids.goal, size.bottomRight(Offset(-width, -width)));
    }
  }

  @override
  bool shouldRelayout(_PlayerAvatarLayoutDelegate oldDelegate) {
    return radius != oldDelegate.radius;
  }
}

class _FormationBanner extends StatelessWidget {
  final String teamName;
  final String formation;

  _FormationBanner(this.teamName, this.formation);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: const Color(0xFF1B9E6D),
      child: Row(
        children: [
          Text(teamName, style: TextStyles.semiBold16.copyWith(color: Colors.white)),
          const Spacer(),
          Text(formation, style: TextStyles.semiBold16.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}

class LocalTeamLineupWidget extends StatelessWidget {
  final ParsedTeamLineup? lineup;

  LocalTeamLineupWidget(this.lineup);

  @override
  Widget build(BuildContext context) {
    ParsedTeamLineup? lineup = this.lineup;
    List<ParsedTeamLineupLine> lines = lineup?.formationLines ?? [];

    if (lineup == null || lines.isEmpty) {
      return Container();
    }

    List<Widget> lineWidgets = [];
    for (int i = 0; i < lines.length; i++) {
      if (i == 0) {
        lineWidgets.add(_GoalKeeperLine(lines[0], true));
        continue;
      }

      if (i == lines.length - 1) {
        lineWidgets.add(_CenterLine(lines[i], true));
        continue;
      }

      lineWidgets.add(_NonCenterLine(lines[i], true));
    }

    return Column(
      children: [_FormationBanner(lineup.teamName, lineup.formation), ...lineWidgets],
    );
  }
}

class VisitorTeamLineupWidget extends StatelessWidget {
  final ParsedTeamLineup? lineup;

  VisitorTeamLineupWidget(this.lineup);

  @override
  Widget build(BuildContext context) {
    ParsedTeamLineup? lineup = this.lineup;
    List<ParsedTeamLineupLine> lines = lineup?.formationLines ?? [];

    if (lineup == null || lines.isEmpty) {
      return Container();
    }

    List<Widget> lineWidgets = [];
    for (int i = lines.length - 1; i >= 0; i--) {
      if (i == 0) {
        lineWidgets.add(_GoalKeeperLine(lines[0], false));
        continue;
      }

      if (i == lines.length - 1) {
        lineWidgets.add(_CenterLine(lines[i], false));
        continue;
      }

      lineWidgets.add(_NonCenterLine(lines[i], false));
    }

    return Column(
      children: [...lineWidgets, _FormationBanner(lineup.teamName, lineup.formation)],
    );
  }
}
