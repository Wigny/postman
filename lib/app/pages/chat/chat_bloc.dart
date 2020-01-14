import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:intl/intl.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:postman/app/models/chat_model.dart';

import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class ChatBloc extends BlocBase {
  final ChatModel chat;
  final UserModel user;
  final HasuraRepository _hasura;
  Dio _dio;

  int _today;

  TextEditingController textController = TextEditingController();
  VideoPlayerController videoController;

  Snapshot _getMessagesSubscription;

  final _controller = BehaviorSubject<List<MessageModel>>();
  Stream<List<MessageModel>> get messageListStream => _controller.stream;
  Sink<List<MessageModel>> get messageListEvent => _controller.sink;

  ChatBloc(this.chat, this.user, this._hasura) {
    _today = DateTime.now().day;
    _dio = Dio(
      BaseOptions(
        // baseUrl: "http://192.168.10.101:3000",

        baseUrl: "https://postman-uploads.herokuapp.com",
        headers: {
          'Content-type': 'multipart/form-data',
          'Accept': 'application/json'
        },
      ),
    );

    _getMessages();
  }

  _getMessages() {
    _getMessagesSubscription = _hasura.subscription(
      GET_MESSAGES,
      variables: {
        'chat_id': chat.id,
      },
    );

    _getMessagesSubscription
        .map(
          (res) => res['data']['chat'][0]['messages']
              .map<MessageModel>(
                (i) => MessageModel.fromJson(i),
              )
              .toList(),
        )
        .listen(messageListEvent.add)
        .onError(print);
  }

  submitMessage({MediaModel mediaModel}) {
    var message = MessageModel(
      content: (textController.text.isNotEmpty) ? textController.text : null,
      userId: user.id,
      chatId: chat.id,
      media: mediaModel,
    );

    _hasura.mutation(
      SEND_MESSAGE,
      variables: {
        'message': message.toJson(),
      },
    ).catchError(print);

    textController.text = '';
  }

  Future<MediaModel> uploadFile() async {
    String filePath = await FilePicker.getFilePath(type: FileType.ANY);

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });

    Function progress = (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    };

    try {
      Response response = await _dio.post(
        "/upload",
        data: formData,
        onSendProgress: progress,
      );

      var media = MediaModel.fromJson(response.data);
      submitMessage(mediaModel: media);
      return media;
    } catch (e) {
      throw e;
    }
  }

  String formatDate(DateTime date) {
    DateFormat dateFormat =
        (date.day == _today) ? DateFormat.jm() : DateFormat.yMd().add_jm();

    return dateFormat.format(
      date.toLocal(),
    );
  }

  Future<VideoPlayerController> setVideoController(String url) async {
    videoController = VideoPlayerController.network(url);

    await videoController.initialize();
    return videoController;
  }

  @override
  void dispose() {
    _controller?.close();
    _getMessagesSubscription?.close();
    super.dispose();
  }
}
