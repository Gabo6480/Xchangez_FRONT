import 'package:Xchangez/model/Lista.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:Xchangez/product/ProductNewItem.dart';
import 'package:Xchangez/services/api.lista.dart';
import 'package:Xchangez/services/api.valoracion.dart';
import 'package:Xchangez/user/ListaNewListForm.dart';
import 'package:Xchangez/user/ValoracionNewForm.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void deleteLista(BuildContext context, Lista list, {Function updateParent}) {
  ThemeData theme = Theme.of(context);
  Alert(
      title: "¿Está seguro que desea eliminar la lista: " + list.nombre + "?",
      desc: "Este es un cambio permanente.",
      context: context,
      type: AlertType.warning,
      buttons: [
        DialogButton(
            color: theme.primaryColor,
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              if (await ListaServices.delete(list.id)) {
                Navigator.pop(context);
                if (updateParent != null) updateParent();
              }
            }),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ]).show();
}

void editLista(BuildContext context, Lista list, {Function updateParent}) {
  ThemeData theme = Theme.of(context);
  final listFormKey = GlobalKey<ListaNewListFormState>();
  Alert(
      title: "Editar lista",
      context: context,
      type: AlertType.none,
      content: ListaNewListForm(
        key: listFormKey,
        editLista: list,
      ),
      buttons: [
        DialogButton(
            color: theme.primaryColor,
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              listFormKey.currentState.save();
              Navigator.pop(context);
              if (updateParent != null) updateParent();
            }),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ]).show();
}

void createLista(BuildContext context, {Function updateParent}) {
  ThemeData theme = Theme.of(context);
  final listFormKey = GlobalKey<ListaNewListFormState>();

  Alert(
      title: "Crear nueva lista",
      context: context,
      type: AlertType.none,
      content: ListaNewListForm(
        key: listFormKey,
      ),
      buttons: [
        DialogButton(
            color: theme.primaryColor,
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              listFormKey.currentState.save();
              Navigator.pop(context);
              if (updateParent != null) updateParent();
            }),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ]).show();
}

void createPublicacion(BuildContext context, {Function updateParent}) {
  final _newProductStateKey = GlobalKey<ProductNewItemState>();
  Alert(
      title: "Nueva publicación",
      context: context,
      type: AlertType.none,
      content: ProductNewItem(
        key: _newProductStateKey,
      ),
      buttons: [
        DialogButton(
          color: Colors.greenAccent,
          child: Text(
            "Publicar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (await _newProductStateKey.currentState.saveAs(false)) {
              Navigator.pop(context);
              if (updateParent != null) updateParent();
            }
          },
        ),
        DialogButton(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Text(
            "Guardar Borrador",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _newProductStateKey.currentState.saveAs(true);
            Navigator.pop(context);
            if (updateParent != null) updateParent();
          },
        ),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ]).show();
}

void createValoracion(BuildContext context, Usuario user,
    {Function updateParent}) {
  final _newStateKey = GlobalKey<ValoracionNewFormState>();
  Alert(
      context: context,
      title: "Valorar a " + user.nombre + " " + user.apellido,
      type: AlertType.none,
      content: ValoracionNewForm(
        user.id,
        key: _newStateKey,
      ),
      buttons: [
        DialogButton(
          color: Colors.greenAccent,
          child: Text(
            "Valorar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (await ValoracionServices.create(
                    _newStateKey.currentState.save()) !=
                null) {
              if (updateParent != null) updateParent();
              Navigator.pop(context);
            }
          },
        ),
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Cancelar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ]).show();
}
