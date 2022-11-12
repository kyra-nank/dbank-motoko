import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float"

actor DBank {

  stable var currentValue: Float = 300;
  // currentValue := 300; // to reset currentValue

  stable var startTime = Time.now();
  // startTime := Time.now(); // to reset time
  Debug.print(debug_show(startTime));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdrawal(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.")
    }
  };

  // query call -> read only, async -> since returning
  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedS = (currentTime - startTime) / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };

}