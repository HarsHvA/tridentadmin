import 'package:TridentAdmin/modals/Match.dart';
import 'package:TridentAdmin/modals/participants.dart';
import 'package:TridentAdmin/modals/transaction.dart';
import 'package:TridentAdmin/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference adminsCollection =
      Firestore.instance.collection('admins');

  final CollectionReference matchesCollection =
      Firestore.instance.collection('customMatchRooms');

  final CollectionReference participantsCollection =
      Firestore.instance.collection('participants');

  final CollectionReference pendingTransactions =
      Firestore.instance.collection('pendingTransaction');

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference groupCollection =
      Firestore.instance.collection('group');

  Future<bool> checkIfAdmin() async {
    bool dog = false;
    String userId = await AuthService().uID();
    try {
      await adminsCollection.document(userId).get().then((value) {
        dog = value.data['isAdmin'] ?? false;
      });
    } catch (e) {
      print(e);
    }
    if (dog) {
      return true;
    } else {
      return false;
    }
  }

  Stream<List<Matches>> get ongoingMatches {
    return matchesCollection
        .where('status', isEqualTo: 'Live')
        .snapshots()
        .map(_matchListFromSnapShot);
  }

  Stream<List<Matches>> get upcomingMatches {
    return matchesCollection
        .where('status', isEqualTo: 'Upcoming')
        .snapshots()
        .map(_matchListFromSnapShot);
  }

  Stream<List<Matches>> get completedMatches {
    return matchesCollection
        .where('status', isEqualTo: 'Completed')
        .snapshots()
        .map(_matchListFromSnapShot);
  }

  Stream<List<Participants>> getParticipantList(matchId) {
    return participantsCollection.document(matchId).snapshots().map((event) {
      List<Participants> participantList = [];
      List list = event.data['participants'];
      for (var i = 0; i < list.length; i++) {
        participantList.add(new Participants(
            gameName: list[i]['gameName'],
            name: list[i]['name'],
            uid: list[i]['uid']));
      }
      return participantList;
    });
  }

  Stream<List<TransactionsModel>> getUserPendingTransaction(userId) {
    CollectionReference transactionCollection = Firestore.instance
        .collection('users')
        .document(userId)
        .collection('transactions');
    return transactionCollection
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((event) {
      return event.documents.map((e) {
        return TransactionsModel(
            amount: e.data['amount'],
            mode: e.data['mode'],
            mobileNo: e.data['mobileNo'],
            status: e.data['status'],
            uid: e.data['uid'],
            transactionId: e.documentID);
      }).toList();
    });
  }

  Stream<List<TransactionsModel>> getUserCompletedTransaction(userId) {
    CollectionReference transactionCollection = Firestore.instance
        .collection('users')
        .document(userId)
        .collection('transactions');
    return transactionCollection
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map((event) {
      return event.documents.map((e) {
        return TransactionsModel(
            amount: e.data['amount'],
            mode: e.data['mode'],
            mobileNo: e.data['mobileNo'],
            status: e.data['status'],
            uid: e.data['uid']);
      }).toList();
    });
  }

  Stream<RoomDetailsModel> getRoomDetails(matchId, id) {
    return groupCollection.document(matchId).snapshots().map((event) {
      return RoomDetailsModel(
          roomId: event.data[id]['roomId'] ?? '',
          id: event.data[id]['id'] ?? '',
          roomPassword: event.data[id]['roomPassword'] ?? '',
          time: event.data[id]['time']);
    });
  }

  Stream<Matches> getMatchDetails(id) {
    return matchesCollection.document(id).snapshots().map((value) {
      return Matches(
          game: value.data['game'] ?? '',
          name: value.data['name'] ?? '',
          status: value.data['status'] ?? '',
          imageUrl: value.data['imageUrl'] ?? '',
          ticket: value.data['ticket'] ?? 0,
          map: value.data['map'] ?? '',
          matchNo: value.data['matchNo'] ?? '',
          maxParticipants: value.data['maxParticipants'] ?? 0,
          perKill: value.data['perKill'] ?? 0,
          prizePool: value.data['prizePool'] ?? '',
          time: value.data['time'],
          id: value.documentID,
          roomId: value.data['roomId'] ?? '',
          roomPassword: value.data['roomPassword'] ?? '',
          description: value.data['description'] ?? '',
          noOfGroups: value.data['noOfGroups'] ?? 0);
    });
  }

  List<Matches> _matchListFromSnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((e) {
      return Matches(
          game: e.data['game'] ?? '',
          name: e.data['name'] ?? '',
          status: e.data['status'] ?? '',
          ticket: e.data['ticket'] ?? 0,
          imageUrl: e.data['imageUrl'] ?? '',
          map: e.data['map'] ?? '',
          matchNo: e.data['matchNo'] ?? '',
          maxParticipants: e.data['maxParticipants'] ?? 0,
          perKill: e.data['perKill'] ?? 0,
          prizePool: e.data['prizePool'] ?? '',
          id: e.documentID,
          time: e.data['time'],
          resultOut: e.data['result'] ?? false,
          roomId: e.data['roomId'] ?? '',
          roomPassword: e.data['roomPassword'] ?? '',
          noOfGroups: e.data['noOfGroups'] ?? 0);
    }).toList();
  }

  Stream<List<TransactionsModel>> get adminPendingTransactions {
    return pendingTransactions
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map(_transactionListFromSnapShot);
  }

  Stream<List<TransactionsModel>> get adminCompletedTransactions {
    return pendingTransactions
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .map(_transactionListFromSnapShot);
  }

  List<TransactionsModel> _transactionListFromSnapShot(
      QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((e) {
      return TransactionsModel(
          amount: e.data['amount'] ?? 0,
          mode: e.data['mode'] ?? '',
          mobileNo: e.data['mobileNo'] ?? 0,
          status: e.data['status'] ?? '',
          uid: e.data['uid'] ?? '',
          transactionId: e.documentID);
    }).toList();
  }
}
