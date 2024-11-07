import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryController extends GetxController {
  var selectedImagePath = ''.obs; // Observable for selected image path

  Future<void> pickImageFromGallery() async {
    // Request storage permissions
    var status = await Permission.storage.request();
    
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setImagePath(pickedFile.path); // Update the selected image path
      } else {
        // Handle the case where no image is selected
        print('No image selected.');
      }
    } else {
      // Handle the case where permission is denied
      print('Storage permission denied.');
    }
  }

  void setImagePath(String path) {
    selectedImagePath.value = path; // Update the selected image path
  }
}
