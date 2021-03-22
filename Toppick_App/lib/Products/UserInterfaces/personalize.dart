import 'package:Toppick_App/Products/Models/a_la_carta.dart';
import 'package:flutter/material.dart';
import 'generic_button_for_modal.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';
import 'modal_screen.dart';

class AddTodoButton extends StatelessWidget {
  AddTodoButton(this.selected);
  final dynamic selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _AddTodoPopupCard(this.selected);
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: GenericButton2(
              "Personalizar", Color(0xFF0CC665), 160, 36, 30, 0, 0, 10, 22, 20),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  _AddTodoPopupCard(this.selected);
  final dynamic selected;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: ModalScreen(selected),
        ),
      ),
    );
  }
}
