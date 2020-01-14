const SIGNUP = '''
  mutation signUpUser(\$nickname: String!, \$username: String!) {
    insert_user(objects: {nickname: \$nickname, username: \$username}) {
      returning {
        id
        nickname
        username
        image {
          url
        }
      }
    }
  }
''';

const CREATE_CHAT = '''
mutation createChat(\$user_id: Int!, \$name: String!, \$description: String, \$image_id: Int) {
  insert_chat(objects: {user_chats: {data: {user_id: \$user_id}}, name: \$name, description: \$description, image_id: \$image_id}) {
    returning {
      id
      name
      description
      image_id
    }
  }
}
''';

const INSERT_USER_IN_CHAT = '''
mutation insertUserInChat(\$chat_id: Int!, \$user_id: Int!) {
  insert_user_chats(objects: {chat_id: \$chat_id, user_id: \$user_id}) {
    affected_rows
  }
}
''';

const CHAT_SUBSCRIPTION = '''
subscription onUserJoinChat(\$offset: Int!, \$user_id: Int) {
  user_chats(where: {user_id: {_eq: \$user_id}}, offset: \$offset) {
    id
    chat {
      id
      name
    }
  }
}
''';

const SEND_MESSAGE = '''
mutation sendMessage(\$message: [message_insert_input!]!) {
  insert_message(objects: \$message) {
     affected_rows
  }
}
''';

const GET_MESSAGES = '''
subscription getMessages(\$chat_id: Int!) {
  chat(where: {id: {_eq: \$chat_id}}) {
    messages(order_by: {sending_at: asc}) {
      id
      content
      sending_at
      user {
        id
        username
        image {
          url
        }
      }
      media {
        url
        mimetype
      }
    }
  }
}
''';

// const GET_LAST_MESSAGE = '''
// subscription getLastMessage(\$chat_id: Int!) {
//   chat(where: {id: {_eq: \$chat_id}}) {
//     messages(order_by: {id: desc}, limit: 1) {
//       id
//       content
//       sending_at
//       user {
//         id
//         username
//         image
//       }
//     }
//   }
// }
// ''';

const SET_LAST_SEEN = '''
mutation (\$user_id: Int!) {
  update_user(_set: {last_seen: "now()"}, where: {id: {_eq: \$user_id}}) {
    affected_rows
  }
}
''';

const GET_USERS = '''
query getUsers(\$nickname: String){
  user(where: {nickname: {_eq: \$nickname}}, order_by: {username: asc}) {
    id
    nickname
    username
    image {
      url
    }
  }
}
''';

const GET_CHAT = '''
subscription getChat(\$user_id: Int!) {
  user_chats(where: {user_id: {_eq: \$user_id}}) {
    chat {
      id
      name
      description
      image {
        url
      }
      messages(order_by: {sending_at: desc}, limit: 1) {
        id
        content
        sending_at
        user {
          username
        }
      }
    }
  }
}
''';

const GET_USERS_CHAT = '''
query getUsersChat(\$chat_id: Int!) {
  user_chats(where: {chat_id: {_eq: \$chat_id}}, order_by: {user: {username: asc}}) {
    user {
      id
      username
      image {
        url
      }
    }
  }
}
''';
