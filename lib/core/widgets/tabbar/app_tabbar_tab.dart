
part of 'app_tabbar.dart';

class _AppTabbarTab<T extends IAppTabbarEnum> extends StatelessWidget {
  const _AppTabbarTab({
    required this.tab,
    this.onTap,
    required this.selectedValue,
  });

  final AppTabbarData tab;
  final T selectedValue;
  final void Function(T value)? onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = tab.value == selectedValue;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap?.call(tab.value as T),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  if (tab.selectedIcon != null ||
                      (tab.unselectedIcon != null && tab.selectedIcon != null))
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.primary : AppColors.whatsappMessageColor,
                        BlendMode.srcIn,
                      ),
                      child:
                      isSelected
                          ? tab.selectedIcon
                          : tab.unselectedIcon ?? tab.selectedIcon,
                    ),
                  Expanded(
                    child: Text(
                      tab.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),

                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isSelected,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                width: double.infinity,
                height: 2,

                decoration: BoxDecoration(
                color: AppColors.black,
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
