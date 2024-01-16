// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../core/data/models/id_name_model.dart';
// import '../../res/style/app_colors.dart';

// class TypesSelectorBar extends StatefulWidget {
//   const TypesSelectorBar({
//     Key? key,
//     this.showIndicator = false,
//     required this.types,
//     required this.onChange,
//   }) : super(key: key);

//   final bool showIndicator;
//   final List<IdNameModel> types;
//   final void Function(int? id, int index) onChange;

//   @override
//   State<TypesSelectorBar> createState() => _TypesSelectorBarState();
// }

// class _TypesSelectorBarState extends State<TypesSelectorBar> {
//   IdNameModel? _selected;
//   late final ScrollController _controller;
//   bool _showStartIndicator = false;
//   bool _showEndIndicator = true;

//   @override
//   void initState() {
//     _selected = widget.types.first;
//     if (widget.showIndicator)
//       _controller = ScrollController()..addListener(_onScrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     if (widget.showIndicator) _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final listView = ListView.builder(
//       controller: widget.showIndicator ? _controller : null,
//       scrollDirection: Axis.horizontal,
//       itemCount: widget.types.length + 2,
//       itemBuilder: (context, index) {
//         if (index == 0 || index == widget.types.length + 1)
//           return const SizedBox(width: 8.0);

//         final type = widget.types[index - 1];
//         return _TypeIcon(
//           type: type,
//           isSelected: _selected == type,
//           onTap: (value) => setState(() {
//             _selected = value;
//             widget.onChange(value?.id, index);
//           }),
//         );
//       },
//     );
//     return SizedBox(
//       height: 40.0,
//       child: widget.showIndicator
//           ? Stack(
//               alignment: Alignment.center,
//               children: [
//                 listView,
//                 _buildScrollStartIndicator(),
//                 _buildScrollEndIndicator(),
//               ],
//             )
//           : listView,
//     );
//   }

//   Widget _buildScrollStartIndicator() {
//     return PositionedDirectional(
//       start: 0.0,
//       child: Opacity(
//         opacity: _showStartIndicator ? 1.0 : 0.0,
//         child: InkWell(
//           child: const Icon(
//             Icons.chevron_left,
//             color: AppColors.SECONDARY_COLOR,
//             size: 32.0,
//           ),
//           onTap: _scrollToStart,
//         ),
//       ),
//     );
//   }

//   Widget _buildScrollEndIndicator() {
//     return PositionedDirectional(
//       end: 0.0,
//       child: Opacity(
//         opacity: _showEndIndicator ? 1.0 : 0.0,
//         child: InkWell(
//           child: const Icon(
//             Icons.chevron_right,
//             color: AppColors.SECONDARY_COLOR,
//             size: 32.0,
//           ),
//           onTap: _scrollToEnd,
//         ),
//       ),
//     );
//   }

//   void _scrollToStart() => _controller.animateTo(
//         _controller.offset - 100.0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );

//   void _scrollToEnd() => _controller.animateTo(
//         _controller.offset + 100.0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );

//   void _onScrollListener() {
//     final offset = _controller.offset;
//     final max = _controller.position.maxScrollExtent;
//     final min = _controller.position.minScrollExtent;

//     if (offset == min && _showStartIndicator)
//       setState(() => _showStartIndicator = false);
//     else if (offset > min && !_showStartIndicator)
//       setState(() => _showStartIndicator = true);

//     if (offset == max && _showEndIndicator)
//       setState(() => _showEndIndicator = false);
//     else if (offset < max && !_showEndIndicator)
//       setState(() => _showEndIndicator = true);
//   }
// }

// class _TypeIcon extends StatelessWidget {
//   const _TypeIcon({
//     Key? key,
//     required this.type,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);

//   final IdNameModel? type;
//   final bool isSelected;
//   final ValueChanged<IdNameModel?> onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//       child: Container(
//         alignment: AlignmentDirectional.center,
//         padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
//         margin: const EdgeInsets.symmetric(horizontal: 4.0),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.PRIMARY_COLOR : Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//         ),
//         child: Text(
//           type?.name ?? 'all'.tr(),
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                 color: isSelected ? Colors.white : null,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//       ),
//       onTap: () => onTap(type),
//     );
//   }
// }
