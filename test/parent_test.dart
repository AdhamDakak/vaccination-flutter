import 'package:flutter_test/flutter_test.dart';
import 'package:vaccination/parent.dart';
void main(){
  test('name validation should return true', (){

    //Act
    bool namevalidation=Parent().createState().NameValidation();
    //Assert
    expect(namevalidation,true );
  });
  test('E-mail validation should return true', (){

    //Act
    bool Emailvalidation=Parent().createState().EmailValidation();
    //Assert
    expect(Emailvalidation,true );
  });
  test('National Id validation should return true', (){

    //Act
    bool nationalIdvalidation=Parent().createState().NationalIdValidation();
    //Assert
    expect(nationalIdvalidation,true);
  });


}