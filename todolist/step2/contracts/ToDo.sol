pragma solidity ^0.8.0;

contract ToDo {
  struct Task {
    uint id;
    uint date;
    string content;
    string author;
    bool done;
  }

  uint lastTaskId;
  uint[] taskIds;
  mapping(uint => Task) tasks;

 event TaskCreated(uint, uint, string, string, bool);

  constructor() ToDo() public {
    lastTaskId = 0;
  }
  function createTask(string calldata _content , string calldata _author) public {
    lastTaskId++;
    tasks[lastTaskId] = Task(lastTaskId,  block.timestamp, _content, _author, false);
    taskIds.push(lastTaskId);
    TaskCreated(lastTaskId,  block.timestamp, _content, _author, false); 
  }

  function getTask(uint id) taskExists(id) public view  
    returns(
      uint,
      uint,
      string memory,
      string memory,
      bool
    ) {

      return(
        id,
        tasks[id].date,
        tasks[id].content,
        tasks[id].author,
        tasks[id].done
      );
    }

    //will not work because cant return array of struct yet in Solidity
    // function getTasks() public view returns(Task[] memory) {
    //  return tasks;
    // }

    function getTaskIds() public constant returns(uint[]) {
      return taskIds;
    }
    modifier taskExists(uint id) {
      if(tasks[id].id == 0) {
        revert();
      }
      _;
    }
}
