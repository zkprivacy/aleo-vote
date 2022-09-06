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