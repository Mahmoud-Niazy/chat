import 'package:image_picker/image_picker.dart';

class PickImageForEditUseCase {
  Future<XFile?> execute()async{
   XFile? image;
   final ImagePicker picker = ImagePicker();
   image = await picker.pickImage(source: ImageSource.gallery);
   return image;
 }
}