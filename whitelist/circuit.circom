include "../../node_modules/circomlib/circuits/mimcsponge.circom";

template Whitelist() {
  signal private input key;
  signal input recipient;
  signal output hash;

  component hasher = MiMCSponge(1, 220, 1);
  hasher.ins[0] <== key;
  hasher.k <== 0;
  hash <== hasher.outs[0];

  // Include the recipient in the circuit
  // so tampering with it invalidates the SNARK
  signal recipientSquared
  recipientSquared <== recipient * recipient
}

component main = Whitelist()
