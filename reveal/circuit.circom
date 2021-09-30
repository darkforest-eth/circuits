/*
    Prove: Public (x,y,PLANETHASH_KEY) is such that:
    - MiMCSponge(x,y) = pub
    - perlin(x, y) = perl
*/

include "../../node_modules/circomlib/circuits/mimcsponge.circom"
include "../../node_modules/circomlib/circuits/comparators.circom"
include "../../node_modules/circomlib/circuits/bitify.circom"
include "../range_proof/circuit.circom"
include "../perlin/perlin.circom"

template Main() {
    signal input x;
    signal input y;
    signal input PLANETHASH_KEY;
    signal input SPACETYPE_KEY;
    signal input SCALE; /// must be power of 2 at most 16384 so that DENOMINATOR works
    signal input xMirror; // 1 is true, 0 is false
    signal input yMirror; // 1 is true, 0 is false

    signal output pub;
    signal output perl;

    /* check abs(x), abs(y) <= 2^31 */
    component n2bx = Num2Bits(32);
    n2bx.in <== x + (1 << 31);
    component n2by = Num2Bits(32);
    n2by.in <== y + (1 << 31);

    /* check MiMCSponge(x,y) = pub */
    /*
        220 = 2 * ceil(log_5 p), as specified by mimc paper, where
        p = 21888242871839275222246405745257275088548364400416034343698204186575808495617
    */
    component mimc = MiMCSponge(2, 220, 1);

    mimc.ins[0] <== x;
    mimc.ins[1] <== y;
    mimc.k <== PLANETHASH_KEY;

    pub <== mimc.outs[0];

    /* check perlin(x, y) = p */
    component perlin = MultiScalePerlin();
    perlin.p[0] <== x;
    perlin.p[1] <== y;
    perlin.KEY <== SPACETYPE_KEY;
    perlin.SCALE <== SCALE;
    perlin.xMirror <== xMirror;
    perlin.yMirror <== yMirror;
    perl <== perlin.out;
}

component main = Main();
