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


// Globals //
const G = &R.dbg;
const A = "25";
const F = "-t";
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
//const L = 3;
const K = []const u8;
const C = gen2S(void);


// Logic //
fn par(g: anytype, d: []u8) !C {

    var c = try C.init(g);

//    var k: [2]K = undefined;

    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        var i: u64 = 0;

        var z: []const u8 = undefined;

        var w = spl(l, ": ");
        while (w.next()) |v| {
            if (v.len == 0) continue;

            defer i += 1;
            
//            assert(i < L+1);

            if (i == 0) {
                c.new(v);
                z = v;
                continue;
            }
        
            try c.add(v, {});
            try c.put(v, z, {});
        }

//        deb("add", k);
    }

    return c;
}


// Preset //
const V = StringHash(void);
const W = StringHash(K);
//const V = genK(Hash, D, Q);


// Run //
fn run(a: anytype, c: anytype, g: anytype) !u64 {

    prs("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

//    _ = a;

    // Debug //
    if (g > 0) {

        G.* = true;
//        s = g;
    }

    // Timestamp //
    const t = tst();
//    _ = t;

    // Visited //
    var q = V.init(a);
    defer q.deinit();

    var n = try q.clone();
    defer n.deinit();


    // Loop //
    var i: u64 = 0;

    c.iterator();
    while (c.next()) |w| {

        const k, _ = w;

        try q.put(k, {});

        prl();
        dpr("{d}> ", .{tst() - t});

        i = 0;
        var f = false;

        var v: K = undefined;

        while (q.count() > 0) {
            defer i += 1;

//            if (i > 0 and q.count() < c.m) break;

            var j = q.keyIterator();

            while (j.next()) |y| {
                const x = y.*;

                if (i <= 0) v = x;

//                if (v.contains(x)) continue;

//                try v.put(x, {});

                if (i > 0) {
                    if (try plx(a, c, x, v)) |z| {

//                        try err("z", z);
                        return z;
                    }
    
                    f = true;

                    continue;
                }

                try pla(c, x, &n, v);
            }

            prl();
            swp(&q, &n);

            n.clearRetainingCapacity();

            if (i > 0) break;
        }

//        v.clearRetainingCapacity();
        q.clearRetainingCapacity();
        n.clearRetainingCapacity();

//        if (f) break;
    }

    try err("fail", 0);
    return 0;
}

fn pla(
    c: anytype,
    x: anytype,
    n: anytype,
    v: anytype,    

) !void {
    
    const l = try c.get(x);

//    deb("l", l.count());

    prc(x, l, v);

    var i = l.keyIterator();

    while (i.next()) |y| {
        const z = y.*;

//        dpr("{s} ", .{z});

        try n.put(z, {});
    }
}

fn plx(
    a: anytype,
    c: anytype,
    x: anytype,
    v: anytype,    

) !?u64 {
    
    const k = try c.get(v);
    const l = try c.get(x);

    var i = l.keyIterator();

    var s: u64 = 0;

    dpr("{s}: ", .{x});

    while (i.next()) |y| {

        const z = y.*;

        dpr("{s} ", .{z});

        if (k.contains(z)) s += 1;
    }

    putd(" ", s);

    if (s <= 1) {
        prl();

        var b = try c.clone();
        defer b.deinit();

        if (try cut(a, &b, x, v, 2)) |r| {

            return r;
        }
    }

    return null;
}

fn cut(
    a: anytype,
    c: anytype,
    xx: anytype,
    vv: anytype,
    rr: anytype,    

) !?u64 {

    var x = xx;
    var v = vv;
    var r: u64 = rr;

    dpr(">> {d}: {s}/{s}\n", .{r, x, v});

    const l = try c.remove(x, v);

    const o = try c.remove(v, x);

    if (r <= 0) return try fin(a, c);

    var s: u64 = E;

//    prc(x, l, "");

    var n = W.init(a);
    defer n.deinit();

    try ins(c, l, x, &n, &s);

    prl();

    try ins(c, o, v, &n, &s);

    prl();

//    deb("s", s);

    var q = try n.clone();
    defer q.deinit();

    r -= 1;

    var i = n.keyIterator();
    while (i.next()) |y| {

        const z = y.*;

        const w = n.get(z).?;

        x = z;
        v = w;

        prl();

        var b = try c.clone();
        defer b.deinit();

        if (try cut(a, &b, x, v, r)) |h| {

            return h;
        }
    }

    while (n.count() > 0) {
        q.clearRetainingCapacity();

        i = n.keyIterator();
        while (i.next()) |y| {

            const z = y.*;

            const w = n.get(z).?;

            dpr(">>> {s}: {s}\n", .{z, w});

            const k = try c.get(z);

    //        var h = k.clone();
    //        defer h.deinit();
    //        _ = h.remove(w);

            try ins(c, k, z, &q, &s);

    //        _ = try ply(c, z, w);

            prl();
        }

        swp(&n, &q);

        if (s <= 1) break;
    }

    i = n.keyIterator();
    while (i.next()) |y| {

        const z = y.*;

        const w = n.get(z).?;

        x = z;
        v = w;

        prl();

        var b = try c.clone();
        defer b.deinit();

        if (try cut(a, &b, x, v, r)) |h| {

            return h;
        }
    }

    return null;
}

const M = 0;

fn ins(
    c: anytype,
    l: anytype,
    x: anytype,
    n: anytype,
    s: anytype,

) !void {

    var i = l.keyIterator();
    while (i.next()) |y| {

        const z = y.*;

//        if (eql(z, x)) continue;
//        dpr("{s} ", .{z});

        const m = try ply(c, z, x);

        if (m <= s.* + M) {

            if (m < s.*) {

//                if (m + M < s.*) n.clearRetainingCapacity();
                s.* = m;
            }

            try n.put(z, x);
        }
    }
}

fn ply(
    c: anytype,
    x: anytype,
    v: anytype,    

) !u64 {
    
    const k = try c.get(v);
    const l = try c.get(x);

    var i = l.keyIterator();

    var s: u64 = 0;

    dpr("{s}: ", .{x});

    while (i.next()) |y| {

        const z = y.*;

        dpr("{s} ", .{z});

        if (k.contains(z)) s += 1;
    }

    putd(" ", s);

    return s;
}

fn fin(
    a: anytype,
    c: anytype,

) !?u64 {

    prl();
    prs("-----------------------------------------------------------");
    prl();
//    putd("c", c.count());

    var t: u64 = 0;


    // Visited //
    var q = V.init(a);
    defer q.deinit();

    var n = try q.clone();
    defer n.deinit();

    var o = try q.clone();
    defer o.deinit();


    // Loop //
    var i: u64 = 0;

    c.iterator();
    while (c.next()) |y| {

        const z, _ = y;

        if (o.contains(z)) continue;

        defer i += 1;

//        prc(z, l, "");

        var v = try q.clone();
        defer v.deinit();

        try q.put(z, {});

        while (q.count() > 0) {

//            deb("q", q.count());

            var j = q.keyIterator();

            while (j.next()) |w| {

                const x = w.*;

//                deb("v", v.count());

                if (v.contains(x)) continue;
                if (o.contains(x)) unreachable;

                if (i > 1) {
                    puts("x", x);

                    try err("i", i);
                }

                try v.put(x, {});

                try pla(c, x, &n, x);
            }

            prl();
            swp(&q, &n);

            n.clearRetainingCapacity();
        }

        const vc = v.count();

        deb("v", vc);

        if (i <= 0) {
            swp(&v, &o);
            continue;
        }

        const oc = o.count();

        deb("o", oc);

        assert(oc+vc == c.count());

        t = oc * vc;
        break;
    }

    prs("===========================================================\n\n");

    if (t <= 0) return null;

    assert(i == 2);

    return t;
}

fn prc(
    k: anytype,
    l: anytype,
    v: anytype,

) void {

    var i = l.keyIterator();

    dpr("{s}: ", .{k});

    while (i.next()) |x| {

//        if (v.contains(x.*)) continue;
        if (eql(v, x.*)) continue;

        dpr("{s} ", .{x.*});        
    }

    prl();
}


// Real Main //
fn rmain(l: anytype, nn: anytype) !void {
    prl();

    var n: u64 = nn;

    const f = "data" ++ A ++ F ++ ".txt";

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

    prl();

    const l = std.testing.allocator;

    try rmain(l, 0);
}
