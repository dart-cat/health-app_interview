import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:vstrecha/data/models/analysis_response.dart';
import 'package:vstrecha/data/models/article.dart';
import 'package:vstrecha/data/models/event_response.dart';
import 'package:vstrecha/data/models/hotline.dart';

import 'package:vstrecha/data/models/institution.dart';
import 'package:vstrecha/data/models/library_section.dart';
import 'package:vstrecha/data/models/paged.dart';
import 'package:vstrecha/data/models/quiz.id.dart';
import 'package:vstrecha/data/models/quiz_questions_id.dart';
import 'package:vstrecha/data/models/response.dart';

part '../../generated/data/providers/api.g.dart';

@RestApi(baseUrl: "http://185.179.83.138/api")
abstract class API {
  factory API(Dio dio, {String baseUrl}) = _API;

  @GET("/laboratories")
  Future<APIResponse<Paged<List<Institution>>>> getInstitutions(
    @Query("page") int page,
  );

  @GET("/help-abroad")
  Future<APIResponse<Paged<List<Institution>>>> getAbroadInstitutions(
    @Query("page") int page,
  );

  @GET("/hotlines")
  Future<APIResponse<Paged<List<Hotline>>>> getHotlines(
    @Query("page") int page,
  );

  @GET("/article-sections")
  Future<APIResponse<List<LibrarySection>>> getLibrarySections();

  @GET("/article/{id}")
  Future<APIResponse<List<Article>>> getArticles(
    @Path("id") int sectionId,
  );

  @POST("/register")
  Future<APIResponse<String>> createAccount(
    @Field("email") String email,
    @Field("password") String password,
    @Field("gender") String gender,
    @Field("types_users") String typesUsers,
    @Field("city") String city,
  );

  @POST("/auth")
  Future<APIResponse<dynamic>> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("/calendar/{user_id}")
  Future<APIResponse<List<EventResponseItem>>> getNotifications(
    @Path("user_id") int userId,
  );

  @POST("/calendar/create")
  Future<APIResponse<String>> addNotification(
    @Field("user_id") int userId,
    @Field("event_type") String eventType,
    @Field("event_name") String title,
    @Field("what_remind") String description,
    @Field("date_start") String dateStart,
    @Field("date_completion") String dateEnd,
    @Field("periodicity") String frequency,
    @Field("time") String times,
    @Field("time_remind") String remindBefore,
  );

  @DELETE("/calendar/delete/{id}")
  Future<APIResponse<String>> deleteNotification(
    @Path("id") int id,
  );

  @GET("/analyzes/{user_id}")
  Future<APIResponse<List<AnalysisResponseItem>>> getAnalyses(
    @Path("user_id") int userId,
  );

  @POST("/analyze/create")
  @MultiPart()
  Future<APIResponse<String>> uploadAnalysis(
    // ignore: non_constant_identifier_names
    @Part() String user_id,
    @Part() String date,
    @Part() File link, {
    @Part() String name = "",
    // ignore: non_constant_identifier_names
    @Part() String category_analysis_id = "1",
  });

  @DELETE("/analyze/delete/{id}")
  Future<APIResponse<String>> deleteAnalysis(
    @Path("id") int id,
  );

  @GET("/polls?user_id={user_id}")
  Future<QuizId> getQuiz(
    @Path("user_id") int userId,
  );

  @GET("/poll/{pull_id}?user_id={user_id}")
  Future<QuizQuestionsId> getQuizQuestions(
    @Path("user_id") int userId,
    @Path("pull_id") int pullId,
  );
   @POST('/save-result-poll')
  Future<APIResponse<dynamic>> postQuiz(
   @Field("user_id") int userid,
   @Field("answer_id") int answer,
   @Field("poll_id") int pullId,
   @Field("question_id") int questionID,
  );
}
