// The 'vtoken.aleo' program.
program vtoken.aleo;

// On-chain storage of an `account` map, with `owner` as the key,
// and `amount` as the value.
mapping account:
    // The token owner.
    key owner as address.public;
    // The token amount.
    value amount as u64.public;

record token:
    // The token owner.
    owner as address.private;
    // The Aleo balance (in gates).
    gates as u64.private;
    // The token amount.
    amount as u64.private;

// Proposal details
interface ProposalInfo:
    title as field;
    content as field;
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

// Count votes of agreement
mapping agree_votes:
    key pid as field.public;
    value amount as u64.public;

// Count votes of disagreement
mapping disagree_votes:
    key pid as field.public;
    value amount as u64.public;

/* Mint */

// The function `mint_public` issues the specified token amount
// for the token receiver publicly on the network.
function mint_public:
    // Input the token receiver.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;
    // Mint the tokens publicly.
    finalize r0 r1;

// The finalize scope of `mint_public` increments the
// `account` of the token receiver by the specified amount.
finalize mint_public:
    // Input the token receiver.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;

    // Increments `account[r0]` by `r1`.
    // If `account[r0]` does not exist, it will be created.
    // If `account[r0] + r1` overflows, `mint_public` is reverted.
    increment account[r0] by r1;

// The function `mint_private` initializes a new record with the
// specified amount of tokens in `r1` for the receiver in `r0`.
function mint_private:
    // Input the token receiver.
    input r0 as address.private;
    // Input the token amount.
    input r1 as u64.private;

    // Produces a token record for the token receiver.
    cast r0 0u64 r1 into r2 as token.record;

    // Output the receiver's record.
    output r2 as token.record;

/* Transfer */

function transfer_public:
    // Input the token receiver.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;
    // Transfer the tokens publicly.
    finalize self.caller r0 r1;

finalize transfer_public:
    // Input the token sender.
    input r0 as address.public;
    // Input the token receiver.
    input r1 as address.public;
    // Input the token amount.
    input r2 as u64.public;

    // Decrements `account[r0]` by `r2`.
    // If `account[r0]` does not exist, it will be created.
    // If `account[r0] - r2` underflows, `transfer_public` is reverted.
    decrement account[r0] by r2;

    // Increments `account[r1]` by `r2`.
    // If `account[r1]` does not exist, it will be created.
    // If `account[r1] + r2` overflows, `transfer_public` is reverted.
    increment account[r1] by r2;

// The function `transfer_private` sends the specified token amount
// to the token receiver from the specified token record.
function transfer_private:
    // Input the sender's record.
    input r0 as token.record;
    // Input the token receiver.
    input r1 as address.private;
    // Input the token amount.
    input r2 as u64.private;

    // Checks the given token record has a sufficient token amount.
    // This `sub` operation is safe, and the proof will fail
    // if an underflow occurs. The destination register `r3` holds
    // the change amount to be returned to the sender.
    sub r0.amount r2 into r3;

    // Produces a token record for the specified receiver.
    cast r1 0u64 r2 into r4 as token.record;

    // Produces a token record with the change amount for the sender.
    cast r0.owner r0.gates r3 into r5 as token.record;

    // Output the receiver's record.
    output r4 as token.record;
    // Output the sender's change record.
    output r5 as token.record;

// The function `transfer_private_to_public` turns a specified token amount
// from a token record into public tokens for the specified receiver.
//
// This function preserves privacy for the caller's record, however
// it publicly reveals the token receiver and the token amount.
function transfer_private_to_public:
    // Input the caller's record.
    input r0 as token.record;
    // Input the token receiver.
    input r1 as address.public;
    // Input the token amount.
    input r2 as u64.public;

    // Checks the given token record has a sufficient token amount.
    // This `sub` operation is safe, and the proof will fail
    // if an underflow occurs. The destination register `r3` holds
    // the change amount for the caller.
    sub r0.amount r2 into r3;

    // Produces a token record with the change amount for the caller.
    cast r0.owner r0.gates r3 into r4 as token.record;

    // Output the caller's change record.
    output r4 as token.record;

    // Increment the token amount publicly for the token receiver.
    finalize r1 r2;

finalize transfer_private_to_public:
    // Input the token receiver.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;

    // Increments `account[r0]` by `r1`.
    // If `account[r0]` does not exist, it will be created.
    // If `account[r0] + r1` overflows, `transfer_private_to_public` is reverted.
    increment account[r0] by r1;

// The function `transfer_public_to_private` turns a specified token amount
// from `account` into a token record for the specified receiver.
// 
// This function preserves privacy for the receiver's record, however
// it publicly reveals the caller and the specified token amount.
function transfer_public_to_private:
    // Input the token receiver.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;

    // Produces a token record for the token receiver.
    cast r0 0u64 r1 into r2 as token.record;

    // Output the receiver's record.
    output r2 as token.record;

    // Decrement the token amount of the caller publicly.
    finalize self.caller r1;

finalize transfer_public_to_private:
    // Input the token owner.
    input r0 as address.public;
    // Input the token amount.
    input r1 as u64.public;

    // Decrements `account[r0]` by `r1`.
    // If `account[r0]` does not exist, it will be created.
    // If `account[r0] - r1` underflows, `transfer_public_to_private` is reverted.
    decrement account[r0] by r1;

// Propose a new proposal.
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
    increment agree_votes[r0] by 0u64;

// Vote with public token. The voter is public.
// vote_public(pid: field, agree: u64, disagree: u64)
function vote_public:
    // pid
    input r0 as field.public;
    // agree
    input r1 as u64.public;
    // disagree
    input r2 as u64.public;
    // sum amount
    add r1 r2 into r3;
    finalize r0 r1 r2 self.caller r3;

finalize vote_public:
    // pid
    input r0 as field.public;
    // agree
    input r1 as u64.public;
    // disagree
    input r2 as u64.public;
    // voter
    input r3 as address.public;
    // amount
    input r4 as u64.public;
    // update votes
    increment agree_votes[r0] by r1;
    increment disagree_votes[r0] by r2;
    // update public token balances
    decrement account[r3] by r2;
    increment account[aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc] by r4;

// Vote with private token. The voter is private.
// vote_private(pid: field, agree: u64, disagree: u64, token: token)
function vote_private:
    // pid
    input r0 as field.public;
    // agree
    input r1 as u64.public;
    // disagree
    input r2 as u64.public;
    // token
    input r3 as token.record;

    // sum amount
    add r1 r2 into r4;

    // change
    sub r3.amount r4 into r5;
    cast r3.owner r3.gates r5 into r6 as token.record;
    output r6 as token.record;

    finalize r0 r1 r2 self.caller r4;

finalize vote_private:
    // pid
    input r0 as field.public;
    // agree
    input r1 as u64.public;
    // disagree
    input r2 as u64.public;
    // voter
    input r3 as address.public;
    // amount
    input r4 as u64.public;
    // update votes
    increment agree_votes[r0] by r1;
    increment disagree_votes[r0] by r2;
    // record voted tokens in zero address
    increment account[aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc] by r4;