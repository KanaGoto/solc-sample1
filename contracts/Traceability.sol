pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Traceability {
  // an array of traceIDs
  uint256[] public traceIdArr;
  uint256 public seq;

  struct TraceInfo{
    uint256 traceId;
    Details details;
  }
  // Model Details
  struct Details{
    address from; //どこから
    address to; //どこへ
    string item; //何を
    uint256 amount; //どれだけ
    uint256 timestamp; //いつ
    // more .. from IoT device
  }

  // Store a track of traceId
  mapping(uint256 => TraceInfo[]) histories;

  constructor() public {
    seq = 1;
  }

  /**
   * 新しいトレース情報を作成
   */
  function createTraceInfo(address from, string memory item, uint amount) public returns (bool success){
    // traceId
    uint256 currentSeq = seq;
    seq ++;
    traceIdArr.push(currentSeq);

    // traceInfo
    TraceInfo memory setup = TraceInfo(currentSeq, Details(from, msg.sender, item, amount, now));
    histories[currentSeq].push(setup);
    return true;
  }

  /**
   * トレース情報の追記
   */
  function addTraceInfo(uint traceId, address from, string memory item, uint amount) public returns (bool success){
    
    TraceInfo memory setup = TraceInfo(traceId, Details(from, msg.sender, item, amount, now));
    histories[traceId].push(setup);
    return true;
  }

  /** 
   * トレース情報を参照
   */
  function viewTraceInfo (uint traceId) public view returns (TraceInfo[] memory) {

    return histories[traceId];    
  }

}
