# vtoken.aleo

`vtoken.aleo` is a token program with voting function.

The program introduces voting features on the basis of [token.aleo](https://github.com/AleoHQ/aleo/tree/testnet3/examples/token).

## Build Guide

To compile this Aleo program, run:
```bash
aleo build
```

## Token functions

### Mint public

Run `mint_public` to mint public token:
```
aleo run mint_public aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl 100u64
```

### Mint private

Run `mint_private` to mint public token:
```
aleo run mint_private aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl 100u64
```

Output sample:
```
{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  amount: 100u64.private,
  _nonce: 4035485712708310765311189352326001911411864245280359513992719528911857252742group.public
}
```

### Transfer public

Run `transfer_public` to transfer public token
```
aleo run transfer_public aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj 100u64
```

### Transfer private

Run `transfer_private` to transfer private token (records).
```
aleo run transfer_private '{
    owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
    gates: 0u64.private,
    amount: 100u64.private,
    _nonce: 4035485712708310765311189352326001911411864245280359513992719528911857252742group.public
}' aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj 10u64
```

Output sample:
```
{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  amount: 10u64.private,
  _nonce: 5308163056358240242102462787719402279930037656248494520145220275554655853548group.public
}
{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  amount: 90u64.private,
  _nonce: 3514960347020695002190057549094667453245139666967375737342728732177826026481group.public
}
```

### Transfer to public

Run `transfer_private_to_public` to transfer and convert private token to public token. The change is private.
```
aleo run transfer_private_to_public '{
    owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
    gates: 0u64.private,
    amount: 100u64.private,
    _nonce: 4035485712708310765311189352326001911411864245280359513992719528911857252742group.public
}' aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj 10u64
```

Output sample:
```
{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  amount: 90u64.private,
  _nonce: 42775268232227709679311662721160239397492917225410101676297128642479011335group.public
}
```

### Transfer to private

Run `transfer_public_to_private` to transfer and convert public token to private token.
```
aleo run transfer_public_to_private aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj 100u64
```

Output sample:
```
{
  owner: aleo1s7p25g4awj6htsaj0qe9y4jf540xldhy4gsktuajk5wgu34hd5pql86mnj.private,
  gates: 0u64.private,
  amount: 100u64.private,
  _nonce: 3186750062632675889649801362941891353510700423921068266233710274991469076661group.public
}
```

## Vote functions

### Propose

Run `propose` to propose a new proposal.
```
aleo run propose '{
    title: 2077160157502449938194577302446444field,
    content: 1452374294790018907888397545906607852827800436field,
    proposer: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl
}'
```

Output sample:
```
{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  id: 5402209430955573454561267507373804385925558521277886561691924734792601164647field.public,
  info: {
    title: 2077160157502449938194577302446444field.public,
    content: 1452374294790018907888397545906607852827800436field.public,
    proposer: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.public
  },
  _nonce: 3930858802423325331136926619947174167535286233161322346435852178068437001458group.public
}
```

### Vote Public

Run `vote_public` to vote for a proposal with public token.
```
aleo run vote_public 5402209430955573454561267507373804385925558521277886561691924734792601164647field 10u64 0u64
```

### Vote Private

Run `vote_private` to vote for a proposal with private token.

```
aleo run vote_private 5402209430955573454561267507373804385925558521277886561691924734792601164647field 10u64 0u64 '{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  amount: 100u64.private,
  _nonce: 4035485712708310765311189352326001911411864245280359513992719528911857252742group.public
}'
```

Output sample:
```
{
  owner: aleo16p65y6evsqa8ysnnl63khvkzmt30rjgrqaug55uku9p08mdzvg9qgl5ltl.private,
  gates: 0u64.private,
  amount: 90u64.private,
  _nonce: 914137269403345156810398045028227777023148094547419321439800257451058103256group.public
}
```