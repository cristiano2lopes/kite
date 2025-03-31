import 'package:dio/dio.dart';
import 'dart:async';

import 'package:kite/common/data_utils.dart';

typedef DataTransformer<T> = T Function(Map<String, dynamic> json);

class DataFetcherException implements Exception {
  final String message;

  DataFetcherException(this.message);
}

class StalledDataException<T> extends DataFetcherException {
  final T data;

  StalledDataException(super.message, this.data);
}

abstract interface class DataFetcher<T> {
  Future<T> fetchData(DataTransformer<T> transformer);
}

class HttpDataFetcher<T> implements DataFetcher<T> {
  final String url;
  final dio = Dio();
  final Future<void> Function(String key, T data)? persistData;

  HttpDataFetcher(this.url, {this.persistData});

  @override
  Future<T> fetchData(DataTransformer<T> transformer) async {
    try {
      final response = await dio.get(url);
      final data = transformer(response.data);
      if(persistData != null){
        String path = Uri.decodeFull(Uri.parse(url).path);
        if(path.startsWith("/")){
          path = path.replaceFirst("/", "");
        }
        await persistData!(path, data);
      }
      return data;
    } on DioException catch (e) {
      final errorResponse = e.response;
      if (errorResponse != null) {
        throw DataFetcherException(errorResponse.data.toString());
      } else {
        throw DataFetcherException("Connection error");
      }
    }
  }


}

class LocalDataFetcher<T> implements DataFetcher<T> {
  final Future<String> Function() readData;
  final bool Function(T data)? isDataStalled;

  LocalDataFetcher({required this.readData, this.isDataStalled});

  @override
  Future<T> fetchData(DataTransformer<T> transformer) async {
    try{
      final contents = await bgDecodeJson(await readData());
      final data = transformer(contents);
      if(isDataStalled != null && isDataStalled!(data)){
        throw StalledDataException("Stalled data", data);
      }
      return data;
    } catch (e) {
      throw DataFetcherException("Error fetching data");
    }
  }


}

class MultiSourceDataFetcher<T> implements DataFetcher<T> {

  final List<DataFetcher<T>> sources;
  T? stalledData;

  MultiSourceDataFetcher(this.sources);

  @override
  Future<T> fetchData(DataTransformer<T> transformer) async {
    for (var fetcher in sources) {
      try{
        return await fetcher.fetchData(transformer);
      } on StalledDataException catch(e) {
        stalledData = e.data;
        continue;
      }
      on DataFetcherException {
        continue;
      }
      on Exception {
        continue;
      }
    }
    return stalledData ?? (throw DataFetcherException("Error fetching data"));
  }

}
