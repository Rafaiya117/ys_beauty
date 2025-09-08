class NavigationModel {
  final int currentIndex;
  final bool isAddNewModalOpen;

  const NavigationModel({
    this.currentIndex = 0,
    this.isAddNewModalOpen = false,
  });

  NavigationModel copyWith({
    int? currentIndex,
    bool? isAddNewModalOpen,
  }) {
    return NavigationModel(
      currentIndex: currentIndex ?? this.currentIndex,
      isAddNewModalOpen: isAddNewModalOpen ?? this.isAddNewModalOpen,
    );
  }
}
