enum CategoryEnum {
  upcoming('Upcoming'),
  completed('Completed'),
  canceled('Canceled');

  const CategoryEnum(this.title);

  final String title;
}