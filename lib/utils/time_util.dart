import 'package:intl/intl.dart';

class TimeUtils {
  static String timeAgo(String uploadTimeString) {
    // Parse the input string to a DateTime object
    final uploadTime = DateTime.parse(uploadTimeString).toLocal();
    
    final now = DateTime.now();
    final difference = now.difference(uploadTime);

    if (difference.inDays > 7) {
      // If the post is more than a week old, show the date
      return DateFormat.yMMMd().format(uploadTime);
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}