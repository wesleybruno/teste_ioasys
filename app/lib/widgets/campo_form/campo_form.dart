import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_selecao/configs/ui/Cores.dart';
import 'package:teste_selecao/configs/ui/DimensoesTela.dart';
import 'package:teste_selecao/configs/ui/Fontes.dart';
import 'package:teste_selecao/widgets/custom_field/custom_field.dart';

class CampoForm extends StatelessWidget {
  final titulo;
  final hintText;
  final fillColor;
  final borderColor;
  final TextStyle textStyle;
  final double alturaCampo;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatter;
  final Function(String) onValidator;
  final Function(String) onChange;
  final Function(String) onFieldSubmitted;
  final FocusNode currentFocus;
  final String initialValue;
  final FocusNode nextFocus;
  final bool enable;
  final String hint;
  final bool isLoading;
  final int max;
  final int maxLines;
  final bool mandatory;
  final bool obscureText;
  final Widget suffixIcon;
  final EdgeInsets padding;
  final width;
  final height;
  final Color focusColor;
  final bool possuiErro;

  const CampoForm({
    Key key,
    this.titulo,
    this.hintText = '',
    this.padding,
    this.fillColor,
    this.textStyle,
    this.borderColor,
    this.alturaCampo,
    this.controller,
    this.keyboardType,
    this.inputFormatter,
    this.onValidator,
    this.onChange,
    this.onFieldSubmitted,
    this.currentFocus,
    this.initialValue,
    this.nextFocus,
    this.enable = true,
    this.hint,
    this.isLoading,
    this.width,
    this.height,
    this.max,
    this.maxLines,
    this.mandatory = false,
    this.suffixIcon,
    this.obscureText,
    this.focusColor,
    this.possuiErro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titulo != null)
          titulo is String
              ? Padding(
                  padding: padding ?? EdgeInsets.all(10.w),
                  child: Text(
                    titulo,
                    style: textStyle ??
                        TextStyle(
                          color: focusColor ?? Colors.black.withOpacity(0.8),
                          fontWeight: Fontes.medium,
                          fontSize: 12.ssp,
                        ),
                  ),
                )
              : titulo,
        Padding(
          padding: padding ??
              EdgeInsets.only(
                left: 8.w,
                right: 8.w,
              ),
          child: CustomField(
            hintText: hintText,
            hintColor: Cores.ruby,
            enable: enable,
            max: max,
            obscureText: obscureText ?? false,
            suffixIcon: suffixIcon,
            width: width != null ? width.w : 374.w,
            height: height != null ? height : 14.h,
            maxLines: maxLines,
            initialValue: initialValue,
            keyboardType: keyboardType ?? TextInputType.text,
            inputFormatter: inputFormatter,
            controller: controller,
            onChange: onChange,
            exibirBordaErro: possuiErro ?? false,
            fillColor: fillColor ?? Cores.branco,
            borderColor: borderColor ?? Cores.claro,
            onValidator: mandatory
                ? onValidator ??
                    (newValue) {
                      if (newValue == null || newValue.length == 0) {
                        return 'Preencha o campo.';
                      }
                      return null;
                    }
                : null,
            textStyle: textStyle,
          ),
        )
      ],
    );
  }
}
