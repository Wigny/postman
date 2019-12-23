const SIGNUP = '''
  mutation signUpUser(\$nickname: String!, \$username: String!) {
    insert_user(objects: {nickname: \$nickname, username: \$username}) {
      returning {
        id
        nickname
        username
        image
      }
    }
  }
''';

const CREATE_CHAT = '''
mutation createChat(\$user_id: Int!, \$name: String!, \$description: String, \$image: String) {
  insert_chat(objects: {user_chats: {data: {user_id: \$user_id}}, name: \$name, description: \$description, image: \$image}) {
    returning {
      id
      name
      description
      image
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
    returning {
      id
      content
      sending_at
      chat_id
      user {
        id
        username
        image
      }
    }
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
        image
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
    image
  }
}
''';

const GET_CHAT = '''
subscription getChat(\$user_id: Int!) {
  user_chats(where: {user_id: {_eq: \$user_id}}) {
    chat {
      id
      name
      image
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
