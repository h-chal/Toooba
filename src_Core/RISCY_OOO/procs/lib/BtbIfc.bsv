import Types::*;
import ProcTypes::*;
import Vector::*;

export NextAddrPred(..);


`ifdef ANONYMOUS_STUDENT_NAP


export NapPred(..);
export NapPredResult(..);

interface NapPred#(type napTokenT);
    method ActionValue#(NapPredResult#(napTokenT)) pred;
endinterface

interface NextAddrPred#(type napTokenT);
    method Action put_pc(Addr pc);
    interface Vector#(SupSizeX2, NapPred#(napTokenT)) pred;
    method Action update(napTokenT token, Maybe#(Addr) brTarget);
    // security
    method Action flush;
    method Bool flush_done;
endinterface

typedef struct {
    Maybe#(Addr) maybeAddr;
    napTokenT token; // info for future training
} NapPredResult#(type napTokenT) deriving(Bits, Eq, FShow);


`else


interface NextAddrPred#(numeric type hashSz);
    method Action put_pc(Addr pc);
    interface Vector#(SupSizeX2, Maybe#(Addr)) pred;
    method Action update(Addr pc, Addr brTarget, Bool taken);
    // security
    method Action flush;
    method Bool flush_done;
endinterface


`endif