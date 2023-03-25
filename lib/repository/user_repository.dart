import '../data/models/post_model.dart';
import '../data/models/user_model.dart';
import '../http/api_client.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<List<UserModel>> fetchUsers() async {
    return await apiClient.http.get('/users').then((response) {
      return (response.data as List)
          .map((post) => UserModel.fromJson(post))
          .toList();
    });
  }

  Future<UserModel> getUserByName(String username) async {
    return await apiClient.http.get('/users/$username').then((response) {
      return UserModel.fromJson(response.data);
    });
  }

  Future<List<UserModel>> getFollowers(String username) async {
    return await apiClient.http.get('/users/$username/followers').then((response) {
      return (response.data as List)
          .map((post) => UserModel.fromJson(post))
          .toList();
    });
  }

  Future<List<PostModel>> getTimeline(String username) async {
    return await apiClient.http.get('/users/$username/timeline').then((response) {
      return (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
    });
  }
}
