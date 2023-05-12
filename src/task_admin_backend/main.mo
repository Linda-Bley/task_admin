import Map "mo:base/HashMap";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import AList "mo:base/AssocList";
import List "mo:base/List";
import Nat "mo:base/Nat";
import AssocList "mo:base/AssocList";
import Stack "mo:base/Stack";
import Trie "mo:base/TrieMap";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Random "mo:base/Random";
import Nat8 "mo:base/Nat8";
import Buffer "mo:base/Buffer";
import Option "mo:base/Option";
import Error "mo:base/Error";

actor {
  type Task = {
    id: Nat;
    description: Text;
    dueDate: Text;
    completed: Bool;
  };
  
  var tasks = Buffer.Buffer<Task>(0);

  public func addTask(description: Text, dueDate: Text) : async Nat {
    let id = tasks.size();
    let newTask = Buffer.Buffer<Task>(0);
    newTask.add({
      id = id + 1;
      description = description;
      dueDate = dueDate;
      completed = false;
    });
    tasks.append(newTask);
    // Buffer.toArray(tasks);
    return id;
  };
  public func deleteTask(id: Nat) : async Bool {
    if (id < tasks.size()) {
      var indexOfData : ?Nat = null;
      var tarea : ?Task = null;
      // Encontrar el mensaje que el publico escogio.
      Buffer.clone(tasks).filterEntries(func(i, item) {
        if (item.id != ?id) return false;
        indexOfData := ?i;
        tarea := ?item;
        return true;
      });
      // var index = Buffer.indexOf<Nat>(id, tasks: Task, Nat.equal);
      let idx : Nat = switch(indexOfData) {
        case null 0;
        case (?Nat) Nat;
      };
      let x = tasks.remove(idx);
      return true;
    } else {
      return false;
    }
  };

  public func completeTask(id: Nat) : async Bool {
    if (id < tasks.size()) {
      var indexOfData : ?Nat = null;
      var tarea : ?Task = null;
      // Encontrar el mensaje que el publico escogio.
      Buffer.clone(tasks).filterEntries(func(i, item) {
        if (item.id != ?id) return false;
        indexOfData := ?i;
        tarea := ?item;
        return true;
      });
      // var indx = Buffer.indexOf<Nat>(id, tasks, Nat.equal);
      let idx : Nat = switch(indexOfData) {
        case null 0;
        case (?Nat) Nat;
      };
      let x = tasks.getOpt(idx);
      let n : Task = switch(x) {
        case null return false;
        case (?Task) Task;
      };
      let completeTask : Task = {
        id = n.id;
        description = n.description;
        dueDate = n.dueDate;
        completed = true;
      };
      // battleBox.put(Option.get<Nat>(indexOfDataMessage, 0), newMessage)
      tasks.put(Option.get<Nat>(indexOfData, 0), completeTask);
      // Buffer.toArray(tasks);
      return true;
    } else {
      return false;
    }
  };

  public func showTasks() : async () {

    Buffer.iterate<Task>(tasks, func (x) {
      let status = if (x.completed) { "Completado" } else { "Pendiente" };
      let dueDate = x.dueDate;
      let message = "Tarea " # Nat.toText(x.id) # ": " # x.description # " - Fecha de vencimiento: " # dueDate # " - Estado: " # status;
      Debug.print(message);
      // Debug.print(Nat.toText(x)); // prints each element in buffer
    });
  };



}
