var Traceability = artifacts.require("./Traceability.sol");

contract("Traceability", function(accounts) {
    it("initializes seq with 1", function(){
        return Traceability.deployed().then(function(instance) {
            return instance.seq();
        }).then(function(seq){
            assert.equal(seq,1);
        });
    });
});