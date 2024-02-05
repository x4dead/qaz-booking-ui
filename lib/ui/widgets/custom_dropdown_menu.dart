import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/ui/widgets/splash_button.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu(
      {super.key,
      required this.menuObjects,
      required this.floatingLabelText,
      required this.hintText,
      this.onSelected,
      this.textEditingController,
      this.initialSelectedObject});
  final List<String> menuObjects;
  final String floatingLabelText;
  final String? initialSelectedObject;
  final String hintText;
  final void Function(String)? onSelected;
  final TextEditingController? textEditingController;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  final _textController = TextEditingController();
  final _menuController = MenuController();
  final FocusNode focusNode = FocusNode();
  final filteredEntries = ValueNotifier<List<String>>([]);
  @override
  void initState() {
    super.initState();
    filteredEntries.value = widget.menuObjects;
    _textController.text = widget.initialSelectedObject ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void filter() {
    final String filterText = _textController.text.toLowerCase();
    if (filterText == '') {
      filteredEntries.value = widget.menuObjects;
    }
    filteredEntries.value = widget.menuObjects
        .where((String entry) => entry.toLowerCase().contains(filterText))
        .toList();
  }

  void handlePressed() {
    if (_menuController.isOpen == true) {
      _menuController.close();
    } else {
      focusNode.requestFocus();
      _menuController.open();
    }
  }

  void closeMenu() {
    if (_menuController.isOpen == true) {
      _menuController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ValueListenableBuilder(
          valueListenable: filteredEntries,
          builder: (context, value, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                MenuAnchor(
                  style: MenuStyle(
                    padding: const MaterialStatePropertyAll(kPZero),
                    elevation: const MaterialStatePropertyAll(0),
                    side: const MaterialStatePropertyAll(BorderSide.none),
                    maximumSize: MaterialStatePropertyAll(
                        Size(constraints.maxWidth, 300)),
                  ),
                  crossAxisUnconstrained: false,
                  alignmentOffset: const Offset(0, -56),
                  controller: _menuController,
                  menuChildren: [
                    TextFieldTapRegion(
                      onTapOutside: (event) {
                        focusNode.unfocus();
                        closeMenu();
                      },
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.colorDarkGray,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          FloatingLabelTextField(
                            onChanged: (p0) => filter(),
                            myFocusNode: focusNode,
                            floatingLabelLeftPosition: 21,
                            floatingLabelTopPosition: -9,
                            contentPadding:
                                const EdgeInsets.fromLTRB(19, 16.5, 19, 12.5),
                            constraints: BoxConstraints(
                                maxHeight:
                                    filteredEntries.value.isEmpty ? 56 : 50),
                            controller: _textController,
                            floatingLabelText: widget.floatingLabelText,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: widget.hintText,
                            suffix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SplashButton(
                                  onTap: handlePressed,
                                  child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: AppColors.colorBlack),
                                ),
                                kSBW20
                              ],
                            ),
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...List.generate(
                                      filteredEntries.value.length,
                                      (index) => SplashButton(
                                          onTap: () {
                                            _textController.text =
                                                filteredEntries.value[index];

                                            _menuController.close();
                                            focusNode.unfocus();
                                            widget.onSelected?.call(
                                                filteredEntries.value[index]);
                                          },
                                          child: SizedBox(
                                            height: 51,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: kPH20V12,
                                              child: Text(
                                                filteredEntries.value[index],
                                                style: AppTextStyle.w500s16,
                                              ),
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                  child: FloatingLabelTextField(
                    onTap: handlePressed,
                    readOnly: true,
                    myFocusNode: focusNode,
                    controller: _textController,
                    floatingLabelText: widget.floatingLabelText,
                    hintText: widget.hintText,
                    suffix: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.keyboard_arrow_down_rounded,
                            color: AppColors.colorBlack),
                        kSBW20
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    });
  }
}


// Map<ShortcutActivator, Intent> _kMenuTraversalShortcuts =
//     <ShortcutActivator, Intent>{
//   LogicalKeySet(LogicalKeyboardKey.arrowUp): const _ArrowUpIntent(),
//   LogicalKeySet(LogicalKeyboardKey.arrowDown): const _ArrowDownIntent(),
// };

// const double _kMinimumWidth = 112.0;

// const double _kDefaultHorizontalPadding = 12.0;

// class _DropdownMenuEntry<T> {
//   const _DropdownMenuEntry({
//     required this.value,
//     required this.label,
//     this.labelWidget,
//     // this.leadingIcon,
//     this.trailingIcon,
//     this.enabled = true,
//     this.style,
//   });

//   final T value;

//   final String label;

//   final Widget? labelWidget;

//   // final Widget? leadingIcon;

//   final Widget? trailingIcon;

//   final bool enabled;

//   final ButtonStyle? style;
// }

// class _DropdownMenu<T> extends StatefulWidget {
//   const _DropdownMenu({
//     super.key,
//     this.enabled = true,
//     this.width,
//     this.menuHeight,
//     // this.leadingIcon,
//     this.trailingIcon,
//     this.label,
//     this.hintText,
//     this.helperText,
//     this.errorText,
//     this.selectedTrailingIcon,
//     this.enableFilter = false,
//     this.enableSearch = true,
//     this.textStyle,
//     this.inputDecorationTheme,
//     this.menuStyle,
//     this.controller,
//     this.initialSelection,
//     this.onSelected,
//     this.requestFocusOnTap,
//     this.expandedInsets,
//     required this.dropdownMenuEntries,
//   });

//   final bool enabled;

//   final double? width;

//   final double? menuHeight;

//   // final Widget? leadingIcon;

//   final Widget? trailingIcon;

//   final Widget? label;

//   final String? hintText;

//   final String? helperText;
//   final String? errorText;
//   final Widget? selectedTrailingIcon;
//   final bool enableFilter;
//   final bool enableSearch;
//   final TextStyle? textStyle;
//   final InputDecorationTheme? inputDecorationTheme;
//   final MenuStyle? menuStyle;
//   final TextEditingController? controller;

//   final T? initialSelection;

//   final ValueChanged<T?>? onSelected;
//   final bool? requestFocusOnTap;

//   final List<_DropdownMenuEntry<T>> dropdownMenuEntries;

//   final EdgeInsets? expandedInsets;

//   @override
//   State<_DropdownMenu<T>> createState() => _DropdownMenuState<T>();
// }

// class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
//   final GlobalKey _anchorKey = GlobalKey();
//   final isMenuOpened = ValueNotifier<bool>(false);
//   // final GlobalKey _leadingKey = GlobalKey();
//   late List<GlobalKey> buttonItemKeys;
//   final MenuController _controller = MenuController();
//   late final TextEditingController _textEditingController;
//   late bool _enableFilter;
//   late List<_DropdownMenuEntry<T>> filteredEntries;
//   List<Widget>? _initialMenu;
//   int? currentHighlight;
//   // double? leadingPadding;
//   bool _menuHasEnabledItem = false;

//   @override
//   void initState() {
//     super.initState();

//     _textEditingController = widget.controller ?? TextEditingController();
//     _enableFilter = widget.enableFilter;
//     filteredEntries = widget.dropdownMenuEntries;
//     buttonItemKeys = List<GlobalKey>.generate(
//         filteredEntries.length, (int index) => GlobalKey());
//     _menuHasEnabledItem =
//         filteredEntries.any((_DropdownMenuEntry<T> entry) => entry.enabled);

//     final int index = filteredEntries.indexWhere(
//         (_DropdownMenuEntry<T> entry) =>
//             entry.value == widget.initialSelection);
//     if (index != -1) {
//       _textEditingController.text = filteredEntries[index].label;
//       _textEditingController.selection =
//           TextSelection.collapsed(offset: _textEditingController.text.length);
//     }
//     // refreshLeadingPadding();
//   }

//   @override
//   void didUpdateWidget(_DropdownMenu<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.enableSearch != widget.enableSearch) {
//       if (!widget.enableSearch) {
//         currentHighlight = null;
//       }
//     }
//     if (oldWidget.dropdownMenuEntries != widget.dropdownMenuEntries) {
//       currentHighlight = null;
//       filteredEntries = widget.dropdownMenuEntries;
//       buttonItemKeys = List<GlobalKey>.generate(
//           filteredEntries.length, (int index) => GlobalKey());
//       _menuHasEnabledItem =
//           filteredEntries.any((_DropdownMenuEntry<T> entry) => entry.enabled);
//     }
//     // if (oldWidget.leadingIcon != widget.leadingIcon) {
//     //   refreshLeadingPadding();
//     // }
//     if (oldWidget.initialSelection != widget.initialSelection) {
//       final int index = filteredEntries.indexWhere(
//           (_DropdownMenuEntry<T> entry) =>
//               entry.value == widget.initialSelection);
//       if (index != -1) {
//         _textEditingController.text = filteredEntries[index].label;
//         _textEditingController.selection =
//             TextSelection.collapsed(offset: _textEditingController.text.length);
//       }
//     }
//   }

//   bool canRequestFocus() {
//     if (widget.requestFocusOnTap != null) {
//       return widget.requestFocusOnTap!;
//     }

//     // switch (Theme.of(context).platform) {
//     //   case TargetPlatform.iOS:
//     //   case TargetPlatform.android:
//     //   case TargetPlatform.fuchsia:
//     return false;
//     // case TargetPlatform.macOS:
//     // case TargetPlatform.linux:
//     // case TargetPlatform.windows:
//     //   return true;
//     // }
//   }

//   // void refreshLeadingPadding() {
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     setState(() {
//   //       leadingPadding = getWidth(_leadingKey);
//   //     });
//   //   });
//   // }

//   void scrollToHighlight() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final BuildContext? highlightContext =
//           buttonItemKeys[currentHighlight!].currentContext;
//       if (highlightContext != null) {
//         Scrollable.ensureVisible(highlightContext);
//       }
//     });
//   }

//   double? getWidth(GlobalKey key) {
//     final BuildContext? context = key.currentContext;
//     if (context != null) {
//       final RenderBox box = context.findRenderObject()! as RenderBox;
//       return box.hasSize ? box.size.width : null;
//     }
//     return null;
//   }

//   List<_DropdownMenuEntry<T>> filter(List<_DropdownMenuEntry<T>> entries,
//       TextEditingController textEditingController) {
//     final String filterText = textEditingController.text.toLowerCase();
//     return entries
//         .where((_DropdownMenuEntry<T> entry) =>
//             entry.label.toLowerCase().contains(filterText))
//         .toList();
//   }

//   int? search(List<_DropdownMenuEntry<T>> entries,
//       TextEditingController textEditingController) {
//     final String searchText = textEditingController.value.text.toLowerCase();
//     if (searchText.isEmpty) {
//       return null;
//     }
//     final int index = entries.indexWhere((_DropdownMenuEntry<T> entry) =>
//         entry.label.toLowerCase().contains(searchText));

//     return index != -1 ? index : null;
//   }

//   List<Widget> _buildButtons(List<_DropdownMenuEntry<T>> filteredEntries,
//       TextEditingController textEditingController, TextDirection textDirection,
//       {int? focusedIndex, bool enableScrollToHighlight = true}) {
//     final List<Widget> result = <Widget>[];
//     for (int i = 0; i < filteredEntries.length; i++) {
//       final _DropdownMenuEntry<T> entry = filteredEntries[i];

//       const double padding =
//           // entry.leadingIcon == null
//           // ? (leadingPadding ??
//           _kDefaultHorizontalPadding;
//       final ButtonStyle defaultStyle;
//       // switch (textDirection) {
//       //   case TextDirection.rtl:
//       defaultStyle = MenuItemButton.styleFrom(
//         padding:
//             EdgeInsets.only(left: _kDefaultHorizontalPadding, right: padding),
//       );
//       // case TextDirection.ltr:
//       //   defaultStyle = MenuItemButton.styleFrom(
//       //     padding: EdgeInsets.only(
//       //         left: padding, right: _kDefaultHorizontalPadding),
//       // );
//       // }

//       ButtonStyle effectiveStyle = entry.style ?? defaultStyle;
//       final Color focusedBackgroundColor = effectiveStyle.foregroundColor
//               ?.resolve(<MaterialState>{MaterialState.focused}) ??
//           Theme.of(context).colorScheme.onSurface;

//       Widget label = entry.labelWidget ?? Text(entry.label);
//       if (widget.width != null) {
//         final double horizontalPadding = padding + _kDefaultHorizontalPadding;
//         label = ConstrainedBox(
//           constraints:
//               BoxConstraints(maxWidth: widget.width! - horizontalPadding),
//           child: label,
//         );
//       }

//       effectiveStyle = entry.enabled && i == focusedIndex
//           ? effectiveStyle.copyWith(
//               backgroundColor: MaterialStatePropertyAll<Color>(
//                   focusedBackgroundColor.withOpacity(0.12)))
//           : effectiveStyle;

//       final Widget menuItemButton = MenuItemButton(
//         key: enableScrollToHighlight ? buttonItemKeys[i] : null,
//         style: effectiveStyle,
//         // leadingIcon: entry.leadingIcon,
//         trailingIcon: entry.trailingIcon,
//         onPressed: entry.enabled
//             ? () {
//                 textEditingController.text = entry.label;
//                 textEditingController.selection = TextSelection.collapsed(
//                     offset: textEditingController.text.length);
//                 currentHighlight = widget.enableSearch ? i : null;
//                 widget.onSelected?.call(entry.value);
//               }
//             : null,
//         requestFocusOnHover: false,
//         child: label,
//       );
//       result.add(menuItemButton);
//     }

//     return result;
//   }

//   void handleUpKeyInvoke(_) => setState(() {
//         if (!_menuHasEnabledItem || !_controller.isOpen) {
//           return;
//         }
//         _enableFilter = false;
//         currentHighlight ??= 0;
//         currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
//         while (!filteredEntries[currentHighlight!].enabled) {
//           currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
//         }
//         final String currentLabel = filteredEntries[currentHighlight!].label;
//         _textEditingController.text = currentLabel;
//         _textEditingController.selection =
//             TextSelection.collapsed(offset: _textEditingController.text.length);
//       });

//   void handleDownKeyInvoke(_) => setState(() {
//         if (!_menuHasEnabledItem || !_controller.isOpen) {
//           return;
//         }
//         _enableFilter = false;
//         currentHighlight ??= -1;
//         currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
//         while (!filteredEntries[currentHighlight!].enabled) {
//           currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
//         }
//         final String currentLabel = filteredEntries[currentHighlight!].label;
//         _textEditingController.text = currentLabel;
//         _textEditingController.selection =
//             TextSelection.collapsed(offset: _textEditingController.text.length);
//       });

//   void handlePressed(MenuController controller) {
//     if (controller.isOpen) {
//       currentHighlight = null;
//       controller.close();
//     } else {
//       // close to open
//       if (_textEditingController.text.isNotEmpty) {
//         _enableFilter = false;
//       }
//       controller.open();
//     }
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _textEditingController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextDirection textDirection = Directionality.of(context);
//     _initialMenu ??= _buildButtons(
//         widget.dropdownMenuEntries, _textEditingController, textDirection,
//         enableScrollToHighlight: false);
//     final DropdownMenuThemeData theme = DropdownMenuTheme.of(context);
//     final DropdownMenuThemeData defaults = _DropdownMenuDefaultsM3(context);

//     if (_enableFilter) {
//       filteredEntries =
//           filter(widget.dropdownMenuEntries, _textEditingController);
//     }

//     if (widget.enableSearch) {
//       currentHighlight = search(filteredEntries, _textEditingController);
//       if (currentHighlight != null) {
//         scrollToHighlight();
//       }
//     }

//     final List<Widget> menu = _buildButtons(
//         filteredEntries, _textEditingController, textDirection,
//         focusedIndex: currentHighlight);

//     final TextStyle? effectiveTextStyle =
//         widget.textStyle ?? theme.textStyle ?? defaults.textStyle;

//     MenuStyle? effectiveMenuStyle =
//         widget.menuStyle ?? theme.menuStyle ?? defaults.menuStyle!;

//     final double? anchorWidth = getWidth(_anchorKey);
//     if (widget.width != null) {
//       effectiveMenuStyle = effectiveMenuStyle.copyWith(
//           minimumSize:
//               MaterialStatePropertyAll<Size?>(Size(widget.width!, 0.0)));
//     } else if (anchorWidth != null) {
//       effectiveMenuStyle = effectiveMenuStyle.copyWith(
//           minimumSize: MaterialStatePropertyAll<Size?>(Size(anchorWidth, 0.0)));
//     }

//     if (widget.menuHeight != null) {
//       effectiveMenuStyle = effectiveMenuStyle.copyWith(
//           maximumSize: MaterialStatePropertyAll<Size>(
//               Size(double.infinity, widget.menuHeight!)));
//     }
//     final InputDecorationTheme effectiveInputDecorationTheme =
//         widget.inputDecorationTheme ??
//             theme.inputDecorationTheme ??
//             defaults.inputDecorationTheme!;

//     final MouseCursor effectiveMouseCursor =
//         canRequestFocus() ? SystemMouseCursors.text : SystemMouseCursors.click;

//     Widget menuAnchor = MenuAnchor(
//       style: effectiveMenuStyle,
//       controller: _controller,
//       menuChildren: menu,
//       crossAxisUnconstrained: false,
//       builder:
//           (BuildContext context, MenuController controller, Widget? child) {
//         assert(_initialMenu != null);
//         final Widget trailingButton = IconButton(
//           isSelected: controller.isOpen,
//           icon: widget.trailingIcon ??
//               const Icon(Icons.keyboard_arrow_down_rounded),
//           selectedIcon: widget.selectedTrailingIcon ??
//               const Icon(Icons.keyboard_arrow_up_rounded),
//           onPressed: () {
//             handlePressed(controller);
//           },
//         );

//         // final Widget leadingButton = Padding(
//         //     padding: const EdgeInsets.all(8.0),
//         //     child: widget.leadingIcon ?? const SizedBox());

//         Widget textField = ValueListenableBuilder(
//             valueListenable: isMenuOpened,
//             builder: (context, value, child) {
//               return TextField(
//                   key: _anchorKey,
//                   mouseCursor: effectiveMouseCursor,
//                   canRequestFocus: canRequestFocus(),
//                   enableInteractiveSelection: canRequestFocus(),
//                   textAlignVertical: TextAlignVertical.center,
//                   style: effectiveTextStyle,
//                   controller: _textEditingController,
//                   onEditingComplete: () {
//                     if (currentHighlight != null) {
//                       final _DropdownMenuEntry<T> entry =
//                           filteredEntries[currentHighlight!];
//                       if (entry.enabled) {
//                         _textEditingController.text = entry.label;
//                         _textEditingController.selection =
//                             TextSelection.collapsed(
//                                 offset: _textEditingController.text.length);
//                         widget.onSelected?.call(entry.value);
//                       }
//                     } else {
//                       widget.onSelected?.call(null);
//                     }
//                     if (!widget.enableSearch) {
//                       currentHighlight = null;
//                     }
//                     controller.close();
//                   },
//                   onTap: () {
//                     handlePressed(controller);
//                   },
//                   onChanged: (String text) {
//                     controller.open();
//                     setState(() {
//                       filteredEntries = widget.dropdownMenuEntries;
//                       _enableFilter = widget.enableFilter;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     contentPadding: kPZero,
//                     border: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     // border: OutlineInputBorder(borderSide: Border.),
//                     enabled: widget.enabled,
//                     label: widget.label,
//                     hintText: widget.hintText,
//                     helperText: widget.helperText,
//                     errorText: widget.errorText,
//                     // prefixIcon: widget.leadingIcon != null
//                     //     ? Container(key: _leadingKey, child: widget.leadingIcon)
//                     //     : null,
//                     suffixIcon: trailingButton,
//                   ).applyDefaults(effectiveInputDecorationTheme));
//             });

//         if (widget.expandedInsets != null) {
//           return textField;
//         }

//         return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                   width: 1,
//                   color:
//                       // isFocused.value == true
//                       // ?
//                       //  Color(0xff375165)
//                       // :
//                       Color(0xffB6CCDD)),
//             ),
//             child: _DropdownMenuBody(
//               width: widget.width,
//               children: <Widget>[
//                 textField,
//                 for (final Widget item in _initialMenu!) item,
//                 trailingButton,
//                 // leadingButton,
//               ],
//             ));
//       },
//     );

//     if (widget.expandedInsets != null) {
//       menuAnchor = Container(
//         alignment: AlignmentDirectional.topStart,
//         padding: widget.expandedInsets?.copyWith(top: 0.0, bottom: 0.0),
//         child: menuAnchor,
//       );
//     }

//     return Shortcuts(
//       shortcuts: _kMenuTraversalShortcuts,
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           _ArrowUpIntent: CallbackAction<_ArrowUpIntent>(
//             onInvoke: handleUpKeyInvoke,
//           ),
//           _ArrowDownIntent: CallbackAction<_ArrowDownIntent>(
//             onInvoke: handleDownKeyInvoke,
//           ),
//         },
//         child: menuAnchor,
//       ),
//     );
//   }
// }

// class _ArrowUpIntent extends Intent {
//   const _ArrowUpIntent();
// }

// class _ArrowDownIntent extends Intent {
//   const _ArrowDownIntent();
// }

// class _DropdownMenuBody extends MultiChildRenderObjectWidget {
//   const _DropdownMenuBody({
//     super.children,
//     this.width,
//   });

//   final double? width;

//   @override
//   _RenderDropdownMenuBody createRenderObject(BuildContext context) {
//     return _RenderDropdownMenuBody(
//       width: width,
//     );
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, _RenderDropdownMenuBody renderObject) {
//     renderObject.width = width;
//   }
// }

// class _DropdownMenuBodyParentData extends ContainerBoxParentData<RenderBox> {}

// class _RenderDropdownMenuBody extends RenderBox
//     with
//         ContainerRenderObjectMixin<RenderBox, _DropdownMenuBodyParentData>,
//         RenderBoxContainerDefaultsMixin<RenderBox,
//             _DropdownMenuBodyParentData> {
//   _RenderDropdownMenuBody({
//     double? width,
//   }) : _width = width;

//   double? get width => _width;
//   double? _width;
//   set width(double? value) {
//     if (_width == value) {
//       return;
//     }
//     _width = value;
//     markNeedsLayout();
//   }

//   @override
//   void setupParentData(RenderBox child) {
//     if (child.parentData is! _DropdownMenuBodyParentData) {
//       child.parentData = _DropdownMenuBodyParentData();
//     }
//   }

//   @override
//   void performLayout() {
//     final BoxConstraints constraints = this.constraints;
//     double maxWidth = 0.0;
//     double? maxHeight;
//     RenderBox? child = firstChild;

//     final BoxConstraints innerConstraints = BoxConstraints(
//       maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
//       maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
//     );
//     while (child != null) {
//       if (child == firstChild) {
//         child.layout(innerConstraints, parentUsesSize: true);
//         maxHeight ??= child.size.height;
//         final _DropdownMenuBodyParentData childParentData =
//             child.parentData! as _DropdownMenuBodyParentData;
//         assert(child.parentData == childParentData);
//         child = childParentData.nextSibling;
//         continue;
//       }
//       child.layout(innerConstraints, parentUsesSize: true);
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       childParentData.offset = Offset.zero;
//       maxWidth = math.max(maxWidth, child.size.width);
//       maxHeight ??= child.size.height;
//       assert(child.parentData == childParentData);
//       child = childParentData.nextSibling;
//     }

//     assert(maxHeight != null);
//     maxWidth = math.max(_kMinimumWidth, maxWidth);
//     size = constraints.constrain(Size(width ?? maxWidth, maxHeight!));
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     final RenderBox? child = firstChild;
//     if (child != null) {
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       context.paintChild(child, offset + childParentData.offset);
//     }
//   }

//   @override
//   Size computeDryLayout(BoxConstraints constraints) {
//     final BoxConstraints constraints = this.constraints;
//     double maxWidth = 0.0;
//     double? maxHeight;
//     RenderBox? child = firstChild;
//     final BoxConstraints innerConstraints = BoxConstraints(
//       maxWidth: width ?? computeMaxIntrinsicWidth(constraints.maxWidth),
//       maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
//     );

//     while (child != null) {
//       if (child == firstChild) {
//         final Size childSize = child.getDryLayout(innerConstraints);
//         maxHeight ??= childSize.height;
//         final _DropdownMenuBodyParentData childParentData =
//             child.parentData! as _DropdownMenuBodyParentData;
//         assert(child.parentData == childParentData);
//         child = childParentData.nextSibling;
//         continue;
//       }
//       final Size childSize = child.getDryLayout(innerConstraints);
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       childParentData.offset = Offset.zero;
//       maxWidth = math.max(maxWidth, childSize.width);
//       maxHeight ??= childSize.height;
//       assert(child.parentData == childParentData);
//       child = childParentData.nextSibling;
//     }

//     assert(maxHeight != null);
//     maxWidth = math.max(_kMinimumWidth, maxWidth);
//     return constraints.constrain(Size(width ?? maxWidth, maxHeight!));
//   }

//   @override
//   double computeMinIntrinsicWidth(double height) {
//     RenderBox? child = firstChild;
//     double width = 0;
//     while (child != null) {
//       if (child == firstChild) {
//         final _DropdownMenuBodyParentData childParentData =
//             child.parentData! as _DropdownMenuBodyParentData;
//         child = childParentData.nextSibling;
//         continue;
//       }
//       final double maxIntrinsicWidth = child.getMinIntrinsicWidth(height);
//       if (child == lastChild) {
//         width += maxIntrinsicWidth;
//       }
//       if (child == childBefore(lastChild!)) {
//         width += maxIntrinsicWidth;
//       }
//       width = math.max(width, maxIntrinsicWidth);
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       child = childParentData.nextSibling;
//     }

//     return math.max(width, _kMinimumWidth);
//   }

//   @override
//   double computeMaxIntrinsicWidth(double height) {
//     RenderBox? child = firstChild;
//     double width = 0;
//     while (child != null) {
//       if (child == firstChild) {
//         final _DropdownMenuBodyParentData childParentData =
//             child.parentData! as _DropdownMenuBodyParentData;
//         child = childParentData.nextSibling;
//         continue;
//       }
//       final double maxIntrinsicWidth = child.getMaxIntrinsicWidth(height);
//       // Add the width of leading Icon.
//       if (child == lastChild) {
//         width += maxIntrinsicWidth;
//       }
//       // Add the width of trailing Icon.
//       if (child == childBefore(lastChild!)) {
//         width += maxIntrinsicWidth;
//       }
//       width = math.max(width, maxIntrinsicWidth);
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       child = childParentData.nextSibling;
//     }

//     return math.max(width, _kMinimumWidth);
//   }

//   @override
//   double computeMinIntrinsicHeight(double height) {
//     final RenderBox? child = firstChild;
//     double width = 0;
//     if (child != null) {
//       width = math.max(width, child.getMinIntrinsicHeight(height));
//     }
//     return width;
//   }

//   @override
//   double computeMaxIntrinsicHeight(double height) {
//     final RenderBox? child = firstChild;
//     double width = 0;
//     if (child != null) {
//       width = math.max(width, child.getMaxIntrinsicHeight(height));
//     }
//     return width;
//   }

//   @override
//   bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
//     final RenderBox? child = firstChild;
//     if (child != null) {
//       final _DropdownMenuBodyParentData childParentData =
//           child.parentData! as _DropdownMenuBodyParentData;
//       final bool isHit = result.addWithPaintOffset(
//         offset: childParentData.offset,
//         position: position,
//         hitTest: (BoxHitTestResult result, Offset transformed) {
//           assert(transformed == position - childParentData.offset);
//           return child.hitTest(result, position: transformed);
//         },
//       );
//       if (isHit) {
//         return true;
//       }
//     }
//     return false;
//   }
// }

// // Hand coded defaults. These will be updated once we have tokens/spec.
// class _DropdownMenuDefaultsM3 extends DropdownMenuThemeData {
//   _DropdownMenuDefaultsM3(this.context);

//   final BuildContext context;
//   late final ThemeData _theme = Theme.of(context);

//   @override
//   TextStyle? get textStyle => _theme.textTheme.bodyLarge;

//   @override
//   MenuStyle get menuStyle {
//     return const MenuStyle(
//       minimumSize: MaterialStatePropertyAll<Size>(Size(_kMinimumWidth, 0.0)),
//       maximumSize: MaterialStatePropertyAll<Size>(Size.infinite),
//       visualDensity: VisualDensity.standard,
//     );
//   }

//   @override
//   InputDecorationTheme get inputDecorationTheme {
//     return const InputDecorationTheme(border: OutlineInputBorder());
//   }
// }
