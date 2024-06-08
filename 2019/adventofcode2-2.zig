const R = @import("class.zig");

const std = R.std;
const fmt = R.fmt;
const io = R.io;
const mem = R.mem;
const debug = R.debug;
const assert = R.assert;
const stdout = R.stdout;
const tst = R.tst;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
const putc = R.putc;
const err = R.err;
const wip = R.wip;
const pr = R.pr;
const dpr = R.dpr;
const prl = R.prl;
const prs = R.prs;

const lin = R.lin;
const toc = R.toc;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;
const itr = R.itr;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;
const StringHashArray = R.StringHashArray;

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;
const genK = R.genK;
const gen2S = R.gen2S;

const spl = R.spl;
const eql = R.eql;
const eq2 = R.eq2;
const max = R.max;
const swp = R.swp;
const dup = R.dup;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const nus = R.nus;
const sum = R.sum;
const pir = R.pir;


// Globals //
const G = &R.dbg;
const F = "2";
//const F = "2-t";
const E = 999999999;


// Input //
//const T = enum {
//    S,
//    F,
//    U,
//    D,
//    L,
//    R
//};
//fn dec(v: anytype) !T {
//    return switch(v) {
//        '#' => T.S,
//        '.' => T.F,
//        '>' => T.F,
//        '<' => T.F,
//        '^' => T.F,
//        'v' => T.F,
//        else => {
//            try err("dec", v);
//            return error.type;
//        }
//    };
//}
//fn sho(v: anytype) !u8 {
//    const w = "#.<>^v";
//
//    for (w) |c| {
//        if (try dec(c) == v) return c;
//    }
//
//    return error.sho;
//}


// Data //
const S = []const u8;
const K = u64;

//const C = genH(K);

const B = Array(K);

const C = gen(K);

const A = struct {

    c: C,
    b: B,

    fn init(a: anytype) @This() {
        var s: @This() = undefined;
        
        s.c = C.init(a);
        s.b = B.init(a);

        return s;
    }

    fn deinit(s: anytype) void {

        s.b.deinit();
        s.c.deinit();
    }
};


// Logic //
fn par(a: anytype, d: []u8) !C {

    var r = C.init(a);

    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        try r.new();

        var i: u64 = 0;

//        var z: K = undefined;

        var w = spl(l, ",");
        while (w.next()) |v| {
            if (v.len == 0) continue;

            defer i += 1;

//            if (!r.b.contains(v)) {
//
//                try r.b.put(v, {});
//            }
//
//            const j = r.b.getIndex(v).?;
//
//            if (i <= 0) {
//
//                z = j;
//                continue;
//            }
//            try r.c.put(j, z);

            const n = try num(u64, v);

            try r.add(n);
        }
    }

    return r;
}


// Target //
const X = 19690720;
const Y = 1000;
const M = 100000;
//const M = 1;


// Run //
fn run(a: anytype, r: anytype, dd: anytype) !u64 {

    _ = a;

    // Debug //
    var d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else Y;

    // Header //
//    const c, const bb = .{r.c, r.b};
    const c = r;

//    const b = b.keys();
//    const c = cc.keys();
//    _ = c;

//    try hdr(c, b, true);

    // Visited //
//    var v = V.init(a);
//    defer v.deinit();
//
//    var n = N.init(a);
//    defer n.deinit();


    // Loop //
    const t = tst();

    var m: u64 = 0;

    const oo = c.items();

    if (d <= 0 or oo.len <= 0) try err("san", .{d, oo.len});

    const o = oo[0];

    if (o.items.len <= 0) try err("sn2", o.items.len);

    var z: u64 = 0;

    while (true) {
        pr("{d}> {d}, {d}\n", .{tst() - t, z, d});

        for (0 .. d) |n| {
        for (0 .. d) |v| {

            if (n < z and v < z) continue;
        
            defer m += 1;

            if (m % M == 0) {
                dpr("{d}>> {d}: {d}, {d}\n", .{tst() - t, m, n, v});

                if (n > E or v > E) try err("oob", .{n, v, E});
            }

            var bb = try o.clone();
            defer bb.deinit();

            var b = bb.items;

            b[1] = n;
            b[2] = v;

            if (try pla(&b)) |w| {

                if (w == X) return fin(n, v);

//                dpr(" --> {any}\n", .{w});
            }
        }}

        z = d;
        d *= 2;
    }

    unreachable;
}

fn pla(
    bb: anytype,

) !?u64 {

    var b = bb.*;

    var x: u64 = 0;

    while (true) {

        assert(x < b.len);

        const v = b[x];

        if (99 == v) break;

        assert(x+3 < b.len);

        const f = b[x+1];
        const s = b[x+2];
        const r = b[x+3];

//        deb("b", .{v, f, s, r});

        assert(f < b.len);
        assert(s < b.len);
        assert(r < b.len);

        b[r] = switch (v) {
            1  => b[f] + b[s],
            2  => b[f] * b[s],

            else => {
                try err("swi", v);
                return null;
            }
        };    

//        deb("r", b[r]);

        x += 4;
    }

    return b[0];
}

fn fin(
    n: anytype,
    v: anytype

) u64 {

    prl();
    prs("-----------------------------------------------------------");
    prl();

    putd("n", n);
    putd("v", n);

    return n*100 + v;
}

//fn fin(
//    a: anytype,
//    b: anytype,
//    e: anytype
//
//) !?u64 {
//
////    prl();
////    prs("-----------------------------------------------------------");
////    prl();
////    putd("c", c.count());
//
//    var t: u64 = 0;
//
//    // Copy //
//    var c = try b.clone();
//    defer c.deinit();
//
//
//    // Visited //
//    var q = W.init(a);
//    defer q.deinit();
//
//    var n = try q.clone();
//    defer n.deinit();
//
//    var o = try q.clone();
//    defer o.deinit();
//
//
//    // Remove // 
//    var y = e.keyIterator();
//
//    while (y.next()) |l| {
//
////    for (e) |y| {
//
//        const i, const j = l.*;
//
//        try c.remove(i, j);
//        try c.remove(j, i);
//    }
//
////    try pra(c);
////    try wip();
//
//    // Loop //
//    var i: u64 = 0;
//
//    const g = c.keys();
//
//    for (g) |z| {
//
//        if (o.contains(z)) continue;
//
//        defer i += 1;
//
////        prc(z, l, "");
//
//        var v = try q.clone();
//        defer v.deinit();
//
//        try q.put(z, {});
//
//        while (q.count() > 0) {
//
////            deb("q", q.count());
//
//            var w = q.keyIterator();
//
//            while (w.next()) |l| {
//
//                const x = l.*;
//
////                deb("v", v.count());
//
//                if (v.contains(x)) continue;
//                if (o.contains(x)) unreachable;
//
//                if (i > 1) {
//                    putd("x", x);
//
//                    try err("i", i);
//                }
//
//                try v.put(x, {});
//
//                try pla(c, x, &n);
//            }
//
////            prl();
//            swp(&q, &n);
//
//            n.clearRetainingCapacity();
//        }
//
//        const vc = v.count();
//
////        deb("v", vc);
//
//        if (i <= 0) {
//            swp(&v, &o);
//            continue;
//        }
//
//        const oc = o.count();
//
////        deb("o", oc);
//
//        assert(oc+vc == c.count());
//
//        t = oc * vc;
//        break;
//    }
//
////    prs("===========================================================\n\n");
//
//    if (t <= 0) return null;
//
//    assert(i == 2);
//
//    return t;
//}

fn prc(
    b: anytype,
    e: anytype,

) void {

    var y = e.keyIterator();

    while (y.next()) |z| {

//    for (l) |y| {

        const i, const j = z.*;

        const x = .{ b[i], b[j] };

//        deb("prc", .{ i, j, x });

        dpr("{s}/{s} ", x);
    }

    prl();
}

fn hdr(
    c: anytype,
    b: anytype,
    e: anytype

) !void {

    const g = c.keys();

    for (g) |k| {

        if (e)            
            dpr("{s}: ", .{ b[k] })
        else
            dpr("{d}: ", .{ k });

        const l = try c.get(k);

        for (l.keys()) |j| {

            const x = .{ b[j] };

            if (e)
                dpr("{s} ", x)
            else
                dpr("{d} ", .{ j });
                
        }

        prl();
    }

    prl();
}

fn pra(
    c: anytype,

) !void {

    const g = c.keys();

    for (g) |k| {

        dpr("{d}: ", .{ k });

        const l = try c.get(k);

        dpr("{d} ", .{ l.keys() });                

        prl();
    }

    prl();
}


// Real Main //
fn rmain(l: anytype, nn: anytype) !void {
    prl();

    var n: u64 = nn;

    const f = "data" ++ F ++ ".txt";

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) G.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Fake Main //
pub fn main() !void {

    // Fun! //
//    var a = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer a.deinit();
//    const l = a.allocator();

    // Speed! //
    var a = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = a.deinit();
    const l = a.allocator();

    try rmain(l, 0);
}


// Test! //
test "main" {
    G.* = true;

    const l = std.testing.allocator;

    try rmain(l, 1);
}
