import HashMap "mo:base/HashMap";
import Time "mo:base/Time";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
 
import Iter "mo:base/Iter";
import Error "mo:base/Error";
import Types "types";

actor
{
  type Member = Types.Member;
  type Result <Ok,Err> = Types.Result<Ok, Err>;
  type HashMap <K,V> = Types.HashMap<K, V>;
  let members = HashMap.HashMap<Principal, Member>(0,Principal.equal,Principal.hash);
    
   public shared ({caller}) func addMember (member: Member) : async Result<() , Text>{
    switch(members.get(caller)) {
      case(null) {
        members.put(caller, member);
        return #ok;
      }
      case (?member){
        return #err ("Member already exists");
      }
    }


   public shared ({caller}) func deleteMember (member: Member) : async Result<() , Text> {
    switch(members.get(caller)) {
      case(?member) {
        members.remove(caller, member);  # OR members.delete(caller);  
        return #ok;
      }
      case (null) {
        return #err ("Member does not exists");
      }
    }
   }

   public shared ({caller}) func updateMember (member: Member) : async
   Result<() , Text>{
    switch(members.get(caller)) {
      case(?member) {
        members.put(caller, member);    
        return #ok;
      }
      case (null) {
        return #err ("Member does not exists");
      }
    }
   }

   public shared ({caller}) func getMember (member: Member) : async Result<() , Text>{
    switch(members.get(caller)) {
      case(?member)
      {
        members.get(caller, member);    
        return #ok;
      }
      case (null) {
        return #err ("Member does not exists");
      }
    }
   }

   public query func getAllMember () : async[Member] {
      return Iter.toArray(members.vals());
   }

   public query func numberOfMembers() : async Nat {
       return members.size();
   }

}