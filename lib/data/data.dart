Map<String, String> vkiReferans = {
  '0-18': '18.5 - 24.9',
  '19-24': '19 - 24',
  '25-29': '20 - 25',
  '30-34': '21 - 26',
  '35-44': '22 - 27',
  '45-54': '23 - 28',
  '55-100': '24 - 29',
};
String? findVKIAraligi(double vki,int age) {
  for (var entry in vkiReferans.entries) {
    var YasAralik = entry.key.split('-');
    var Yasmin = int.parse(YasAralik[0]);
    var Yasmax = int.parse(YasAralik[1]);
    if(age>= Yasmin && age<= Yasmax){
      var aralik = entry.value.split(' - ');
      var min = double.parse(aralik[0]);
      var max = double.parse(aralik[1]);
      if (vki >= min && vki <= max) {
        return "sağlıklı \n             Bu şekilde devam edin";
      }else{
        return "sağlıksız \n               Kilonuza dikkat edin";
      }
    }
  }
  return null;
}