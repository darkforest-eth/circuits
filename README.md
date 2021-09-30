# Dark Forest ZK Circuits

## Development Guide

### Folder setup

Each of the primary Dark Forest circuits is stored in its own subdirectory:

- `/circuits/init`: Proof for initializing a player into the universe
- `/circuits/move`: Proof for initiating a move between two planets
- `/circuits/reveal`: Proof for broadcasting/revealing the coordinates of a
  planet. Note that nothing in the broadcast action needs to happen in
  "zero-knowledge"; we just found it easier to implement verification of MiMC
  hash preimage via a ZK verifier than via a Solidity verifier.
- `/circuits/biomebase`: Proof that a planet has a given `biomebase`, which in
  combination with the planet's `spacetype` will specify the planet's biome.

There are two additional subdirectories for auxiliary utility circuits:

- `/circuits/perlin`: Perlin Noise ZK Circuit.
- `/circuits/range_proof`: Proof that an input, or list of inputs, has an
  absolute value that is at most a user-provided upper bound.

### Installing Core Dependencies

- Node (v14.x OR v16.x)
- Yarn (Javascript Package Manager)

#### Installing The Correct Node Version Using NVM

Dark Forest is built and tested using Node.js v14/v16 and might not run properly on other Node.js versions. We recommend using NVM to switch between multiple Node.js version on your machine.

Refer to [nvm's official documentation](https://github.com/nvm-sh/nvm#installing-and-updating) for the installation guide.

After the installation is finished, you can run `node --version` to verify that you are running v14 or v16

#### Installing Yarn & Other Dev Dependencies

Refer to [Yarn's official documentation](https://classic.yarnpkg.com/en/docs/install) for the installation guide.

After you have Yarn installed, run `yarn` to install dependencies.

### Local Usage

This set of circuits is meant to be used in conjunction with the public smart
contract subdirectory [eth](https://github.com/darkforest-eth/eth) and [Project
Sophon's](https://github.com/projectsophon)
[hardhat-circom](https://github.com/projectsophon/hardhat-circom) plugin. If these two
directories are unified as sibling directories under a common root, you can run
`yarn circom:dev` in `eth` to compile and run the circuits on provided input files.

For your convenience, a sample `input.json` and `public.json` pair is included
for sanity test checks. `input.json` is a sample input, `public.json` is public
parameters. `yarn dev` or `yarn prod` will create `witness.json` and
`verification_key.json`, and print to the console verifying that the proof is
generated and verifies properly.
