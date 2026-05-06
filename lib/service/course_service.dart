import '../model/course.dart';

class CourseService {
  static List<Course> courses = [];

  static void addCourse(Course course) {
    courses.add(course);
  }

  static List<Course> getCourses() {
    return courses;
  }
}     