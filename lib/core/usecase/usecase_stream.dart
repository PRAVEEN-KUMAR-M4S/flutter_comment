
abstract interface class UserCaseStream<SuccessType,Param> {
  Stream call(Param params);
  
}

class Noparam {
  
}