import HashMap "mo:base/HashMap";
import Time "mo:base/Time";
import Result "mo:base/Result";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

module {
public type Result <Ok, Err> = Result.Result<Ok, Err>;
public type HashMap <Ok, Err> = HashMap.HashMap<Ok, Err>;

public type Member = {
    name: Text;
    age: Nat;
}

}