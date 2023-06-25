import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/slot.model.dart';
import '../../../models/slot_type.enum.dart';

const startHour = 8;

class SlotCard extends StatefulWidget {
  final Slot slot;
  final double hourHeight;
  final double left;
  final double width;
  late final double top;

  SlotCard({
    Key? key,
    required this.slot,
    required this.hourHeight,
    required this.left,
    required this.width,
  }) : super(key: key) {
    top = (slot.start - startHour) * hourHeight;
  }

  @override
  State<SlotCard> createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard>
    with SingleTickerProviderStateMixin {
  final padding = 2.0;

  late AnimationController _controller;

  late Animation<Offset> _tweenAnimation;
  late Animation<Size> _sizeAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void didChangeDependencies() {
    final width = MediaQuery.of(context).size.width;
    _computeAndStartAnimation(Offset(width / 2, 0), Size.zero,
        delay: Duration(milliseconds: Random().nextInt(1500)));
    super.didChangeDependencies();
  }

  void _computeAndStartAnimation(Offset startOffset, Size startSize,
      {Duration delay = Duration.zero}) {
    _tweenAnimation = Tween<Offset>(
      begin: startOffset,
      end: Offset(widget.left, widget.top),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );
    _sizeAnimation = Tween<Size>(
      begin: startSize,
      end: Size(widget.width, widget.slot.computeHeight(widget.hourHeight)),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );
    _controller.reset();
    Future.delayed(delay, () => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SlotCard oldWidget) {
    if (oldWidget.left != widget.left ||
        oldWidget.slot.start != widget.slot.start ||
        oldWidget.hourHeight != widget.hourHeight ||
        oldWidget.width != widget.width ||
        oldWidget.slot.duration != widget.slot.duration) {
      _computeAndStartAnimation(
          Offset(oldWidget.left, oldWidget.top),
          Size(
            oldWidget.width,
            oldWidget.slot.computeHeight(oldWidget.hourHeight),
          ));
    } else {
      _computeAndStartAnimation(
          Offset(widget.left, widget.top),
          Size(
            widget.width,
            widget.slot.computeHeight(widget.hourHeight),
          ));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.translate(
          offset: _tweenAnimation.value,
          child: SizedBox(
            width: _sizeAnimation.value.width,
            height: _sizeAnimation.value.height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding,
              ),
              child: child,
            ),
          ),
        );
      },
      animation: _controller,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: _getSlotColor(),
            width: 1,
          ),
          //color: _getSlotColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.slot.id,
            style: const TextStyle(color: Colors.black, fontSize: 8),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.longestLine,
            textHeightBehavior: const TextHeightBehavior(),
          ),
        ),
      ),
    );
  }

  Color _getSlotColor() {
    const opacity = 1.0;
    switch (widget.slot.type) {
      case SlotType.openingKeynote:
        return Colors.yellowAccent.withOpacity(opacity);
      case SlotType.conf:
        return Colors.blueAccent.withOpacity(opacity);
      case SlotType.pause:
        return Colors.greenAccent.withOpacity(opacity);
      case SlotType.quickie:
        return Colors.redAccent.withOpacity(opacity);
      case SlotType.workshop:
        return Colors.orangeAccent.withOpacity(opacity);
      case SlotType.closingKeynote:
        return Colors.yellowAccent.withOpacity(opacity);
      default:
        return Colors.white.withOpacity(opacity);
    }
  }
}
