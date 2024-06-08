const R = @import("class.zig");

const std = R.std;
const assert = R.assert;
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
const swp = R.swp;
const nus = R.nus;


// Globals //
const G = &R.dbg;
//const F = "9";
const F = "9-t";
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
//const S = []const u8;
const K = i64;

//const C = genH(K);

//const B = Array(K);

const C = gen(K);

//const A = struct {
//
//    c: C,
//    b: B,
//
//    fn init(a: anytype) @This() {
//        var s: @This() = undefined;
//        
//        s.c = C.init(a);
//        s.b = B.init(a);
//
//        return s;
//    }
//
//    fn deinit(s: anytype) void {
//
//        s.b.deinit();
//        s.c.deinit();
//    }
//};


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

            const n = try nus(K, v);

            try r.add(n);
        }
    }

    return r;
}

// Preset //
//const M = 100000;
const M = 1;


// Input //
const I = 1;
const S = struct {
    u64,
    K,
    K,
};


// Run //
fn run(a: anytype, c: anytype, dd: anytype) !K {

    _ = a;

    // Debug //
    const d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else I;

    // Header //
//    const c, const bb = .{r.c, r.b};

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
    var r: K = 0;

    for (c.items()) |o| {

        defer m += 1;

        if (m % M == 0) dpr("\n>> {d} : {d}\n", .{m, tst() - t});

        deb("o", o.items);

//        for (0 .. d) |n| {
//        for (0 .. d) |v| {

//            if (n < z and v < z) continue;
        
        var b = try o.clone();
        defer b.deinit();

        var s: S = .{ 0, 0, @intCast(d) };

        while (true) {

            if (try pla(&b, &s)) |w| {

//                if (w == X) return fin(n, v);

                deb("b", b.items);

                putd("w", w);

                r = w;

//                return w;
                break;
            }

            deb("-->", s);
        }
    }

//        }}

//        z = d;
//        d *= 2;

    return r;
}

fn pla(
    c: anytype,
    w: anytype,

) !?K {
    var x, var r, var y = w.*;

    var m: [3]u64 = undefined;

    while (true) {

        const o = x;

        const v = try cod(c, &x, &m);

        if (99 == v) return y;

        if (3 == v) {
            deb("inp", c.items[o..o+2]);

            assert(m[0] != 1);

            const f = try adr(c, &x, m[0], r);

            try set(c, f, y);
            continue;
        }

        const f = try val(c, &x, m[0], r);

        if (9 == v) {
            deb("rel", .{ c.items[o..o+2], r, f });

            r += f;
            continue;
        }

        if (4 == v) {
            deb("out", c.items[o..o+2]);

            y = f;
            break;
        }

        const s = try val(c, &x, m[1], r);

        if (v >= 5 and v <= 6) {
            deb("jmp", c.items[o..o+3]);

            if ((v == 5 and f != 0) or (v == 6 and f == 0)) x = @intCast(s);

            continue;
        }

        const z: K = switch (v) {

            1 => f + s,
            2 => f * s,

            7 => if (f < s) 1 else 0,
            8 => if (f == s) 1 else 0,

            else => {
                try err("pla", v);
                return null;
            }
        };

        deb("oth", c.items[o..o+4]);

        const g = try adr(c, &x, m[2], r);

        try set(c, g, z);
    }

    w.* = .{x, r, y};
    return null;
}

fn set(
    c: anytype,
    y: anytype,
    z: anytype,

) !void {

    const x: u64 = @intCast(y);

    while (x >= c.items.len) try c.*.append(0);

    const b = c.items;

    assert(x < b.len);

    b[ x ] = z;
}

fn get(
    c: anytype,
    y: anytype,

) !K {

    if (y < 0) try err("get", y);

    const x: u64 = @intCast(y);

    while (x >= c.items.len) try c.*.append(0);

    const b = c.items;

    return b[ x ];
}

fn cod(
    c: anytype,
    x: anytype,
    m: anytype,

) !u64 {

    const a = try adr(c, x, 0, 0);

    var d: u64 = @intCast(a);

    m.* = .{0, 0, 0};

    const v = d % 100;
    d /= 100;

    if (d > 0) {
        
        m[0] = dig(&d);

        if (d > 0) {
            
            m[1] = dig(&d);

            if (d > 0) {
            
                if (d > 0) m[2] = dig(&d);
            }
        }
    }

    return v;
}

fn dig(
    d: anytype,

) u64 {
    
    const t = d.* % 10;

    d.* /= 10;

    assert(t < 3);

    return t;
}

fn adr(
    c: anytype,
    x: anytype,
    m: anytype,
    r: anytype,

) !K {

//    assert(m != 1);

    var a = try get(c, x.*);

    if (m == 2) a += r;

    x.* += 1;

    return a;
}

fn val(
    c: anytype,
    x: anytype,
    m: anytype,
    r: anytype,

) !K {

    const a = try adr(c, x, m, r);

    if (m == 1) return a;

    return try get(c, a);
}

fn fin(
    n: anytype,
    v: anytype

) K {

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
