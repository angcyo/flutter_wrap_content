library flutter_wrap_content;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
/// 用最小的约束包裹住child, 用自身的约束限制child的最大宽高
/// Email:angcyo@126.com
/// @author angcyo
/// @date 2023/11/20
///

class WrapContentLayout extends SingleChildRenderObjectWidget {

  /// 对齐方式
  final AlignmentDirectional alignment;

  /// 指定最小的宽度, 不指定则使用[child]的宽度
  /// [BoxConstraints.minWidth]
  final double? minWidth;
  final double? minHeight;

  const WrapContentLayout({
    super.key,
    super.child,
    this.alignment = AlignmentDirectional.center,
    this.minWidth,
    this.minHeight,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => WrapContentBox(
        alignment: alignment,
        textDirection: Directionality.of(context),
        minWidth: minWidth,
        minHeight: minHeight,
      );

  @override
  void updateRenderObject(BuildContext context, WrapContentBox renderObject) {
    renderObject
      ..alignment = alignment
      ..minWidth = minWidth
      ..minHeight = minHeight
      ..markNeedsLayout();
  }
}

/// [rebuild]->[performRebuild]->[updateChild]->[inflateWidget]->
/// [mount]->[attachRenderObject]->[insertRenderObjectChild].(renderObject.child = child;)
/// [RenderObjectWithChildMixin.child]
/// 要自己实现位置偏移需要考虑, 绘制时的偏移和点击事件的偏移
/// [RenderShiftedBox.paint]实现绘制上的偏移
/// [RenderShiftedBox.hitTestChildren]实现点击事件的偏移
class WrapContentBox extends RenderAligningShiftedBox {
  double? minWidth;
  double? minHeight;

  WrapContentBox({
    super.alignment,
    super.textDirection,
    this.minWidth,
    this.minHeight,
  });

  /// 对齐子元素, 通过修改[child!.parentData]这样的方式手势碰撞就会自动计算
  void _alignChild() {
    if (child != null) {
      var dx = 0.0;
      var dy = 0.0;
      switch (alignment) {
        case AlignmentDirectional.topStart:
        case AlignmentDirectional.centerStart:
        case AlignmentDirectional.bottomStart:
          dx = 0;
          break;
        case AlignmentDirectional.topCenter:
        case AlignmentDirectional.center:
        case AlignmentDirectional.bottomCenter:
          dx = (size.width - child!.size.width) / 2;
          break;
        case AlignmentDirectional.topEnd:
        case AlignmentDirectional.centerEnd:
        case AlignmentDirectional.bottomEnd:
          dx = size.width - child!.size.width;
          break;
      }
      switch (alignment) {
        case AlignmentDirectional.topStart:
        case AlignmentDirectional.topCenter:
        case AlignmentDirectional.topEnd:
          dy = 0;
          break;
        case AlignmentDirectional.centerStart:
        case AlignmentDirectional.center:
        case AlignmentDirectional.centerEnd:
          dy = (size.height - child!.size.height) / 2;
          break;
        case AlignmentDirectional.bottomStart:
        case AlignmentDirectional.bottomCenter:
        case AlignmentDirectional.bottomEnd:
          dy = size.height - child!.size.height;
          break;
      }
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset(dx, dy);
    }
  }

  @override
  void performLayout() {
    //debugger();
    if (child == null) {
      size = constraints.smallest;
    } else {
      //在可以滚动的布局中, maxWidth和maxHeight会是无限大
      child!.layout(
        BoxConstraints(
          minWidth: minWidth ?? 0,
          minHeight: minHeight ?? 0,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        ),
        parentUsesSize: true,
      );
      size = constraints.constrain(child!.size);
      _alignChild();
    }
  }
}

extension WrapContentLayoutEx on Widget {
  /// 用最小的约束包裹住child, 用自身的约束限制child的最大宽高
  WrapContentLayout wrapContent({
    AlignmentDirectional alignment = AlignmentDirectional.center,
    double? minWidth,
    double? minHeight,
  }) =>
      WrapContentLayout(
        alignment: alignment,
        minWidth: minWidth,
        minHeight: minHeight,
        child: this,
      );
}
