const R = @import("class.zig");

const std = R.std;
const assert = R.assert;
const tst = R.tst;
const fmt = R.fmt;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;
const StringHashArray = R.StringHashArray;

const gen = R.gen;
const genH = R.genH;
const genK = R.genK;
const genQ = R.genQ;
const genD = R.genD;

const ini = R.ini;
const res = R.res;
const eql = R.eql;
const spl = R.spl;
const spls = R.spls;
const swp = R.swp;
const nus = R.nus;
const eq2 = R.eq2;
const nex = R.nex;
const sort = R.sort;
const max = R.max;
const vll = R.vll;
const vl2 = R.vl2;
const dec = R.dec;

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


// Globals //
const G = &R.dbg;
const K = i64;
const L = [2]K;
const F = "6";

// _______________________________________________________ //

// Input symbols //
const W = ".#^>V<X";
const S = enum {
    E,
    F,
    U,
    R,
    D,
    L,
    V
};

// Input Data //
const A = genK(Hash, 2, K, S);

const P = struct {
    k: L,
    s: S
};

const B = gen(K);
const C = struct {

    h: A,
    a: B,

    g: P,

    pub fn init(a: anytype) !@This() {

        var c: @This() = undefined;

        c.h = try A.init(a);
        c.a = B.init(a);

        return c;
    }

    pub fn add(c: anytype, v: anytype) !void {

        try c.a.add(v);
    }

    pub fn new(c: anytype) !void {

        try c.a.new();
    }

    fn deinit(c: anytype) void {

        c.h.deinit();
        c.a.deinit();
    }
};


// Decode //
pub fn vlc(c: anytype, l: anytype, i: anytype) !void {

    var j: K = 0;

    for (l) |x| {
        defer j += 1;

        var v = try dec(x, W, S);

        const k = .{i, j};

        _ = switch(v) {

            S.E => {},
            S.F => {},

            else => {
                c.g.k = k;
                c.g.s = v;

                v = S.E;
            }
        };

        try c.*.h.add(k, v);
    }

    if (i > 0) try c.*.new();
}


// Logic //
fn par(a: anytype, d: []u8) !C {

    var c = try C.init(a);
//    try c.new();

    var ls = spl(d, "\n");
    var i: K = 0;

    var f = true;

    while (ls.next()) |l| {
        defer i += 1;

        if (l.len <= 0) {

            f = false;
            continue;
        }

        if (f) {

            try vlc(&c, l, i);

        } else {

            deb("l", l);
            try err("l", l.len);

//            try vll(&c, l, ",");
        }
    }

    return c;
}


// Status //
//const S = struct {
//    u64,
//    K,
//    K,
//};
//const B = genD(Hash(K, K), K);


// Run //
fn run(a: anytype, c: anytype, dd: anytype) !K {

    // Debug //
    const d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else 1;

    _ = a;

    c.h.prd(W);

    var v = try c.h.clone();
    defer v.deinit();

    var m: u64 = 0;
    var z: K = 0;

    const b = c.h.b;

    while (true) {

        assert(inv(c.g.k, b));

        defer m += 1;

        try v.add(c.g.k, S.V);

        if (m % d == 0) {
            dpr("\n{d}> {any}\n\n", .{m, c.g.k});

            v.prd(W);
        }

        if (try pla(&c)) break;
    }

    v.prd(W);

    v.iterator();

    while (v.next()) |kv| {

        _, const w = kv;

        if (w == S.V) z += 1;
    }

    return z;
}

fn inv(g: anytype, b: anytype) bool {

    for (0..2) |d| {
        const x = g[d];
        const w = b[d];

        if (x < w[0] or x > w[1]) return false;
    }

    return true;
} 

// Data //
const V = Hash(K, void);


// Machine state //
//const B = struct {
//    Array(K),
//    S,
//};
//const D = struct {
//    pub fn d(_: L, c: B) void {
//
//        c[0].deinit();
//    }
//}.d;
//const Q = genQ(L, B);


// Preset //
//const M = 10000;
//const M = 1;

fn lop(
    a: anytype,
    c: anytype,
    l: anytype,

) !bool {

//    const m = if (d > 0) d else M;

//    _ = a;
//    _ = m;

    // Visited //
    var v = V.init(a);
    defer v.deinit();

//    // Queue //
//    var q = try Q.init(a, D);
//    defer q.deinit();
//
//
//    // Init //
//    const p: L = .{ 0, 0 };
//    const s: S = .{ 0, 0, 0 };
//
//    // Queue auto-deinits everything in it with destructor //
//    const c = try b.clone();
//    try q.add(p, .{ c, s });
//    try v.add(p, 3);
//
//
//    var i: u64 = 0;
//    const t = tst();
//
//    var o: ?L = null;
//
//    while (q.next()) |w| {
//
//        defer i += 1;
//        const z, const g = w;
//        defer D(z, g);
//
//        if (i % m == 0) {
//            dpr("\n>> {d} : {d}\n", .{i, tst() - t});
//
//            v.prd(sho);
//        }
//
//        if (try sea(z, g, &q, &v)) |n| {
//
//            if (o) |_| try err("2ox", n);
//
//            o = n;
//        }
//   }

    for (l) |j| {

        try v.put(j, {});

        const q = c.getn(j);

        const p = if (q) |g| g else continue;

        const s = p.keys();

        for (s) |k| {

            const y = v.get(k);

            if (y) |_| {

                return false;
            }
        }
    }

    return true;
}

fn pla(
    c: anytype,

) !bool {

    const g = c.*.g;
    const h = c.*.h;

    const k = try dir(g);

    const v = h.getn(k) orelse return true;

    if (v == S.E) {

        c.*.g.k = k;

    } else {

        c.*.g.s = try rot(g.s);
    }

    return false;
}

fn dir(g: anytype) !L {

    const d: L = switch (g.s) {

        S.U => .{-1,  0},
        S.R => .{ 0,  1},
        S.L => .{ 0, -1},
        S.D => .{ 1,  0},

        else => {
            try err("dir", g.s);
            return error.dir;
        }
    };

    return nex(g.k, d);
}

fn rot(s: anytype) !S {

    return switch (s) {

        S.U => S.R,
        S.R => S.D,
        S.D => S.L,
        S.L => S.U,

        else => {
            try err("rot", s);
            return error.rot;
        }
    };
}

//fn cln(
//    c: anytype,
//    l: anytype,
//    r: anytype
//
//) !B {
//
//    const b = try c.clone();
//    r.* = true;
//
//    return .{b, l};
//}

//fn sea(
//    p: anytype,
//    w: anytype,
//    q: anytype,
//    v: anytype,
//
//) !?L {
//
//    const c, const l = w;
//
//    var r = false;
//    var b, var s = try cln(c, l, &r);
//
//    var o: ?L = null;
//
//    for (1..5) |i| {
//
//        if (!r) b, s = try cln(c, l, &r);
//
//        // TODO: optimize //
//        s[2] = @intCast(i);
//
//        const d = dir(i);
//
//        const n = nex(d, p);
//
//        assert(!eq2(n, p));
//
//        if (v.contains(n)) continue;
//
//        if (try pla(&b, &s)) |x| {
//
//            try err("exi", x);
//        }
//
//        // IO //
//        const z = s[2];
//
////            deb("z", .{n, z, d});
//
//        try v.add(n, z);
//
//        _ = switch (z) {
//
//            0 => continue,
//
//            1 => {},
//
//            2 => o = n,
//
//            else => try err("swi", z)
//        };
//
//        // Step //
//        try q.add(n, .{ b, s });
//        r = false;
//    }
//
//    if (r) b.deinit();
//
//    return o;
//}
//
//
//const H = genQ(L, void);

//fn fil(
//    a: anytype,
//    p: anytype,
//    v: anytype,
//
//) !u64 {
//    
//    var q = try H.init(a, null);
//    defer q.deinit();
//
//    try v.add(p, 2);
//    try q.put(p);
//
//    var i = q.steps();
//
//    while (q.next()) |w| {
//
//        const z, _ = w;
//
//        if (q.s != i) {
//            i = q.s;
//
//            deb("s", q.s);
//            v.prd(sho);
//        }
//
//        for (1..5) |g| {
//            const d = dir(g);
//
//            const n = nex(d, z);
//
//            if (!v.contains(n)) continue;
//
//            const x = try v.get(n);
//
//            if (x == 0 or x == 2) continue;
//
//            try v.add(n, 2);
//            try q.put(n);
//        }
//    }
//
//    // Starting pos //
//    return q.steps() - 1;
//}
//
//fn nex(
//    d: anytype,
//    p: anytype,
//
//) L {
//
//    return .{d[0] + p[0], d[1] + p[1]};
//}
//
//fn dir(
//    i: anytype,
//
//) L {
//    return switch(i) {
//        1 => .{-1,  0},
//        2 => .{ 1,  0},
//        3 => .{ 0, -1},
//        4 => .{ 0,  1},
//        else => .{0, 0}
//    };
//}


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

    while (x >= c.items.len)
        try c.append(0);

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

// _______________________________________________________ //


// Real Main //
fn rmain(l: anytype, nn: anytype, f: anytype) !void {
    prl();

    var n: u64 = nn;

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) G.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Main -- wrapper //
pub fn main() !void {

    // Fun! //
//    var a = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer a.deinit();
//    const l = a.allocator();

    // Speed! //
    var a = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = a.deinit();
    const l = a.allocator();

    try rmain(l, 0, undefined);
}


// Test -- wrapper //
test "main" {
    G.* = true;

    const l = std.testing.allocator;

    const f = "data" ++ F ++ "-t.txt";

    try rmain(l, 1, f);
}
