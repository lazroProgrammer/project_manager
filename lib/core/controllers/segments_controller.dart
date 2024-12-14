import 'package:drift/drift.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tasks/database/daos/segments_dao.dart';
import 'package:tasks/database/database.dart';

class SegmentsController extends GetxController {
  RxList<Segment> segments = RxList<Segment>();
  RxInt projectID = (-1).obs;

  final SegmentsDao dao = SegmentsDao(AppDatabase());
  Logger log = Logger();

  Future<void> getAll() async {
    try {
      final result = await dao.getAllSegment();
      segments.assignAll(result);
    } catch (e) {
      log.e('Failed to fetch Segments: $e');
    }
  }

  Future<void> getSegmentsByProjectID(int projectId) async {
    projectID = projectId.obs;
    final result = await dao.getSegmentsByProjectID(projectID.value);
    segments.assignAll(result);
  }

  Future<void> insertSegment(SegmentsCompanion segment) async {
    try {
      final result = await dao.insertSegment(segment);
      if (result >= 0) {
        final newSegment = await dao.getSegmentByID(result);
        if (newSegment != null) {
          if (segment.segmentID == const d.Value.absent()) {
            segments.add(newSegment);
            Fluttertoast.showToast(msg: "Segment successfully added");
          } else {
            int index = segments
                .indexWhere((s) => s.segmentID == segment.segmentID.value);
            if (index != -1) {
              segments[index] = newSegment;
              Fluttertoast.showToast(msg: "Segment successfully updated");
            } else {
              Fluttertoast.showToast(msg: "Segment not found");
            }
          }
        } else {
          Fluttertoast.showToast(msg: "oops something went wrong");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add Segments");
      log.e('Failed to insert Segment: $e');
    }
  }

  Future<void> editSegment(SegmentsCompanion segment) async {
    final json = segment.toJson();
    final result = await dao.editSegmentByID(json["segmentID"], json);
    if (result >= 0) {
      final newsegment = await dao.getSegmentByID(result);
      int index =
          segments.indexWhere((p) => p.segmentID == segment.segmentID.value);
      if (newsegment != null) {
        if (index != -1) {
          segments[index] = newsegment;
          Fluttertoast.showToast(msg: "segment successfully updated");
        } else {
          Fluttertoast.showToast(msg: "segment not found");
        }
      } else {
        Fluttertoast.showToast(msg: "oops, you gotta get something");
      }
    } else {
      Fluttertoast.showToast(msg: "oops something went wrong");
    }
  }

  Future<int> deleteSegmentById(int id) async {
    try {
      final result = await dao.deleteSegmentByID(id);
      if (result > 0) {
        segments.removeWhere((segment) => segment.segmentID == id);
      }
      return result;
    } catch (e) {
      log.e('Failed to delete Segment: $e');
      return -1;
    }
  }
}
