import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatBase with _$ChatController;

abstract class _ChatBase with Store {
  final ChatModel chat;
  final UserModel user;
  int today;

  @observable
  ObservableList<MessageModel> messageList = <MessageModel>[
    MessageModel(
      chatId: 1,
      content: "vai dormir",
      id: 103,
      sendingAt: DateTime.parse("2020-01-15T04:58:38.371931+00:00"),
      userId: 4,
      user: UserModel(
        id: 5,
        image: MediaModel(
          url:
              "https://storagepostman.blob.core.windows.net/files/552ee9b3-d9b1-4fd6-b457-3c3f791669b6.jpeg",
        ),
        nickname: "wigny",
        username: "Wígny",
      ),
    ),
  ].asObservable();

  _ChatBase(this.chat, this.user) {
    today = DateTime.now().day;
  }
  @observable
  String newMessage;

  @action
  addMessage(MessageModel message) => messageList.add(message);

  @action
  setNewMessage(String v) => newMessage = v;

  submitMessage() {
    var message = MessageModel(
      content: newMessage,
      user: user,
      chatId: chat.id,
      sendingAt: DateTime.now(),
    );

    addMessage(message);
  }

  String formatDate(DateTime date) {
    DateFormat dateFormat =
        (date.day == today) ? DateFormat.jm() : DateFormat.yMd().add_jm();

    return dateFormat.format(
      date.toLocal(),
    );
  }
}
