class AppValidator{

  String? senha;

  static String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z\u00C0-\u00FF ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "O e-mail não deve ficar em branco, digite novamente!";
    } else if (!regExp.hasMatch(value)) {
      return "O e-mail informado é inválido!";
    }         
    return null;    
  }
  
  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "A senha não deve ficar em branco, digite novamente!";
    }

    if (value.length < 8) {
      return "A senha deve ter mais que 8 digitos";
    }
    senha = value;
    return null;
  }

   String? validatePasswordEquals(String? value) {

    if (value != senha) {
      return "As senhas devem ser iguais, digite novamente!";
    }

    return null;
  }
  static String? validateCPF(String? value) {   
    var pattern = r'^[0-9]{3}[.][0-9]{3}[.][0-9]{3}[-][0-9]{2}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "CPF é obrigatório";
    } else if (!regExp.hasMatch(value)) {
      return "CPF informado é inválido!";
    }
    return null;
  }
  static String? validateDateNasc(String? value){
    var pattern = r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Data de nascimento é obrigatória";
    }else if (!regExp.hasMatch(value)) {
      return "A Data de nascimento inválida!";
    }
    return null;
  }
}