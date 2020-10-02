enum UserType { teacher , student , admin  }
extension userTypeExt on UserType {
  String toArString(){
    switch (this) {
      case UserType.student: return "طالب";
      case UserType.teacher: return "مدرس";
      case UserType.admin: return "مسؤول";
      default : return "";
    }
  }
}