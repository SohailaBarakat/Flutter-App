class MedicalForm {
  String? message;

  MedicalForm({this.message});
  factory MedicalForm.fromJson(Map<String, dynamic> json) {
    MedicalForm f = MedicalForm();
    f.message = json['message'];
    return f;
  }
}
