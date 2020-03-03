class Notlar {
  int id;
  String name;

  Notlar(this.id, this.name);

  Map toJson() => {
        'id': id,
        'name': name,
      };

  static List<Notlar> getCompanies() {
    return <Notlar>[
      Notlar(1, 'AA'),
      Notlar(2, 'BA'),
      Notlar(3, 'BB'),
      Notlar(4, 'CB'),
      Notlar(5, 'CC'),
      Notlar(6, 'DC'),
      Notlar(7, 'DD'),
      Notlar(8, 'FD'),
      Notlar(9, 'FF'),
      Notlar(10, 'F0'),
    ];
  }
}