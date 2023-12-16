import 'package:flutter/material.dart';
import 'package:flutter_wrap_content/flutter_wrap_content.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget container(Widget child) => Container(
        color: Colors.red,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: child,
      );

  Widget textWidget({
    Color color = Colors.white,
    String text = "文本内容",
  }) =>
      Container(
        color: color,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var m = 10;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_wrap_content'),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Text(
                "在普通容器(Container)中↓",
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "正常布局(会撑满)"),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "正常布局" * m),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "wrap_content布局(自适应)").wrapContent(),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                textWidget(text: "wrap_content布局" * m).wrapContent(),
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                "在容器(Row)中↓",
                textAlign: TextAlign.center,
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [Expanded(child: textWidget(text: "正常布局(会撑满)"))],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [Expanded(child: textWidget(text: "正常布局" * m))],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    Expanded(
                        child: textWidget(text: "wrap_content布局(自适应)")
                            .wrapContent())
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: container(
                Row(
                  children: [
                    Expanded(
                        child: textWidget(text: "wrap_content布局" * m)
                            .wrapContent())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
