// Bundles different elapsed times
class Stats {
  // Total time taken in the isolate where the inference runs
  int totalPredictTime;
  // Time for which inference runs
  int inferenceTime;
  // Time taken to pre-process the image
  int preProcessingTime;

    int totalElapsedTime;

  Stats(
      {required this.totalPredictTime,
       required this.totalElapsedTime,
      required this.inferenceTime,
      required this.preProcessingTime});

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, totalElapsedTime: $totalElapsedTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}