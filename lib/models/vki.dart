class VKI {
  int age;
  double height;
  double weight;

  VKI({required this.age, required this.height, required this.weight});

  double vkiHesapla() {
    return weight / ((height / 100) * (height / 100));
  }
}
