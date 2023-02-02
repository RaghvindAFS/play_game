import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:play_game/widgets/customTextField.dart';


void main() {
  runApp( HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  //  HotreloadWidgetbook({Key? key}) : super(key: key);
  final TextEditingController c = TextEditingController(text:'test');
 


  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'Text field',
              useCases: [
                WidgetbookUseCase(
                  name: 'Custom',
                  builder: (context) => Center(child: CustomTextFormField(controller: c , label: 'label', hint: 'hint', error: 'error', keyboard: TextInputType.text))
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
