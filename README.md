# Postmortem for open-source operating systems

## What's this?

The [postmortem](https://landing.google.com/sre/sre-book/chapters/postmortem-culture/) is a major technique to learn failure in [Site Reliability Engineering (SRE)](https://en.wikipedia.org/wiki/Site_Reliability_Engineering).
SRE people also submits that such failure may be avoided by resolutions.
Same approach is found at industrial companies.
It's [root cause analysis](https://en.wikipedia.org/wiki/Root_cause_analysis).

On the other hand, are these postmortems common in open source culture?
No, unfortunately.

This project's goal is finding resolutions, such as language or verifier, which are suitable to avoid failures or bugs, which causes security incident.

## What do you choose concrete operating system as target?

We are focusing on [FreeBSD kernel](https://github.com/freebsd/freebsd/tree/master/sys) today, because it has many informations about the bugs on [their security advisory](https://www.freebsd.org/security/advisories.html).

## How to avoid the bugs?

There are two choices.
First is re-writing a part of operating system with language or verifier.
The part should re-write the patch of security incident and be runnalbe.
But this approach needs huge human resource.

Second is writing small pseud code to be proved or verified.
Now, we are choosing this approach with small resource.

Our pseud code is found at following:

* [Postmortem for FreeBSD kernel](./Security-Advisory/FreeBSD-kernel)

## An example of [ATS2](http://www.ats-lang.org/) language

For example, [the ATS2 pseud code](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs/Resolution/ATS2/error/main.dats) causes compile error,
because the code forgets `fdrop` after calling `copyin`.
This mistake occurred at [FreeBSD-SA-19:15.mqueuefs](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs).
It means this bug may be avoided, if FreeBSD was written by ATS2 language.

You can add `fdrop` calling to [fix this bug](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs/Resolution/ATS2/fix/main.dats).

## An example of [VeriFast](https://github.com/verifast/verifast) verifier

For example, [the C pseud code with annotations](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs/Resolution/VeriFast/error/main.c) causes error on verification,
because the code just returns without calling `fdrop`.
This mistake occurred at [FreeBSD-SA-19:15.mqueuefs](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs).
It means this bug may be avoided, if FreeBSD was verified by VeriFast verifier.

You can write `goto out` instead of `return error` to [fix this bug](./Security-Advisory/FreeBSD-kernel/FreeBSD-SA-19:15.mqueuefs/Resolution/VeriFast/fix/main.c).

## Requirements

* [ATS-Postiats](http://www.ats-lang.org/) to prove ATS2 code
* [GCC](https://gcc.gnu.org/) to compile C code translated by ATS2
* [VeriFast](https://github.com/verifast/verifast) to verify C code with annotations

We are testing this program on [Debian GNU/Linux](https://www.debian.org/).

## Proof and verify

```
$ git clone git@github.com:metasepi/postmortem.git
$ cd postmortem
$ make
```

## Acknowledgements

* [Advisers](./Adviser.md) kindly support this project

## License

[MIT](./LICENSE)
