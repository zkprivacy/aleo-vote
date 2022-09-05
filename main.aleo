// The 'vote.aleo' program.
program vote.aleo;

// Proposal details
interface ProposalInfo:
    title as field;
    content as field;
    // todo: wait bug-fix, https://github.com/AleoHQ/aleo/issues/334
    // title as string;
    // content as string;
    proposer as address;

// Proposal record records proposal info publicly
// Delete this if mapping is more convenient to access
record Proposal:
    owner as address.private;
    gates as u64.private;
    id as field.public;
    info as ProposalInfo.public;

// Save proposal info in public storage
// Delete this if record is more convenient to access
mapping proposals:
    key id as field.public;
    value info as ProposalInfo.public;

// Privacy tickets to vote
record Ticket:
    owner as address.private;
    gates as u64.private;
    pid as field.public;

// Count the total tickets issued for each proposal
mapping tickets:
    key pid as field.public;
    value count as u64.public;

// Count votes of agreement
mapping agree_votes:
    key pid as field.public;
    value count as u64.public;

// Count votes of disagreement
mapping disagree_votes:
    key pid as field.public;
    value count as u64.public;

// Propose a new proposal
// propose(proposal: ProposalInfo)
function propose:
    // proposal
    input r0 as ProposalInfo.public;
    // check proposer
    assert.eq self.caller r0.proposer;

    // generate proposal id
    hash.bhp256 r0 into r1;
    // create record
    cast self.caller 0u64 r1 r0 into r2 as Proposal.record;
    output r2 as Proposal.record;

    // finalize r1 r0;
    finalize r1;

finalize propose:
    // id
    input r0 as field.public;
    // proposal
    // input r1 as ProposalInfo.public;
    // todo: delete below, save to proposals mapping
    increment tickets[r0] by 0field;

// new_ticket(pid: field, voter: address)
function new_ticket:
    // pid
    input r0 as field.public;
    // voter
    input r1 as address.public;

    // todo: check caller to be the proposer

    // create record
    cast r1 0u64 r0 into r2 as Ticket.record;
    output r2 as Ticket.record;

    finalize r0;

finalize new_ticket:
    // pid
    input r0 as field.public;
    // count tickets
    increment tickets[r0] by 1field;

// agree(ticket: Ticket.record)
function agree:
    // ticket
    input r0 as Ticket.record;
    finalize r0.pid;

finalize agree:
    input r0 as field.public;
    increment agree_votes[r0] by 1field;

// disagree(ticket: Ticket.record)
function disagree:
    // ticket
    input r0 as Ticket.record;
    finalize r0.pid;

// disagree(pid: field)
finalize disagree:
    input r0 as field.public;
    increment disagree_votes[r0] by 1field;
