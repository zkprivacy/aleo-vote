# vote.aleo

`vote.aleo` is a general vote program.

Anyone can propose new proposals, proposer can issued tickets to the voters, and the voter can vote without exposing privacy (with the help of Aleo's flexible privacy mechanism).

Proposal information and statistical voting results is public, while the correlation between the voter and the vote is private(protected by zk).

## Build Guide

To compile this Aleo program, run:
```bash
aleo build
```

## Run Guide

### Propose

Anyone can propose new proposals publicly by calling `propose` function.

Run `propose`:

```
aleo run propose '{
    title: 2077160157502449938194577302446444field,
    content: 1452374294790018907888397545906607852827800436field,
    proposer: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj
}'
```

Output sample:

```
{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  id: 2264670486490520844857553240576860973319410481267184439818180411609250173817field.public,
  info: {
    title: 2077160157502449938194577302446444field.public,
    content: 1452374294790018907888397545906607852827800436field.public,
    proposer: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.public
  },
  _nonce: 280173640756971825406250624895670696873328256985444996313808294079544987748group.public
}
```

### Create Ticket

Proposer can create new tickets for proposed proposals.

Ticket is a record with `owner` and `pid`, it can be used to vote for the specific proposal - `pid`, and can only be used(voted) by the ticket `owner`.

Run `new_ticket`:

```
aleo run new_ticket 2264670486490520844857553240576860973319410481267184439818180411609250173817field aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj
```

Output sample:

```
{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  pid: 2264670486490520844857553240576860973319410481267184439818180411609250173817field.public,
  _nonce: 6788426462193031877407800463517600390546218000789002569120191107600717342346group.public
}
```

### Vote

Ticket owner can use the ticket to vote `agree` / `disagree` with the specific proposal - `pid`.

As the ticket record can be used as an input privately, the voter's privacy is protected by zk.

Run `agree`:

```
aleo run agree '{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  pid: 2264670486490520844857553240576860973319410481267184439818180411609250173817field.public,
  _nonce: 4675364915186477829414055775071705010930997404255426773474401686947437097344group.public
}'
```

Run `disagree`:

```
aleo run disagree '{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  pid: 2264670486490520844857553240576860973319410481267184439818180411609250173817field.public,
  _nonce: 4675364915186477829414055775071705010930997404255426773474401686947437097344group.public
}'
```
