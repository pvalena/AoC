// Import //
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
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;
const gen2S = R.gen2S;

const spl = R.spl;
const eql = R.eql;
const swp = R.swp;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const sum = R.sum;


// Globals //
const dbg = &R.dbg;
const aoc = "22";

// Debug //
const D = 1000000;
//const D = 1;
const suf = "-t";



// Parse input //
const T = enum {
    S,
    R,
    F
};
fn dec(v: anytype) !T {
    return switch(v) {
        'S' => T.S,
        '#' => T.R,
        '.' => T.F,
        else => {
            try err("dec", v);
            return error.type;
        }
    };
}

//const S = enum {
//    L,
//    H,
//};
//fn ind(v: anytype) !S {
//    return switch(v[0]) {
//        'l' => S.L,
//        'h' => S.H,
//        else => {
//            try err("ind", v);
//            return error.type;
//        }
//    };
//}
//
//const N = []const u8;
//const M = struct {
//    t: T,
//    s: S,
//    c: Array(N)
//};
const K = [3]u64;
const Q = struct {
    k: K,
    d: usize,
    v: u64
};


// Data //
const A = HashArray(Q, void);
//const B = gen2S(S);
const C = struct {
    a: A,
    b: K,

    l: mem.Allocator,

    fn init(l: anytype) C {
        var c: C = undefined;

        c.a = A.init(l);
//        c.b = try B.init(l);

        c.b = .{0, 0, 0};

        c.l = l;

        return c;
    }

    fn clone(o: anytype) !C {

        var c: C = undefined;

//        c.a = A.init(l);
        c.a = try o.a.clone();

        c.b = o.b;

        c.l = o.l;

        return c;
    }

//    fn new(c: anytype) M {
//        var m: M = undefined;
//
//        m.c = Array(N).init(c.l);
//
//        return m;
//    }

    fn count(c: anytype) u64 {

        return c.a.count();
    }

    fn add(c: anytype, v: anytype) !void {

        for (0..3) |i| {
            if (v.k[i] > c.b[i]) c.b[i] = v.k[i];
        }

        try c.a.put(v, {});
    }

    fn remove(c: anytype, v: anytype) !void {

        if (c.a.swapRemove(v)) return;

        try err("C.remove", v);
    }

//    fn put(c: anytype, n: anytype, v: anytype) !void {
//
//        try c.a.put(n, v);
//    }
//
//    fn add(c: anytype, x: anytype, t: anytype) !void {
//
//        if (c.a.contains(x)) return error.AlreadyIn;
//
//        var o = c.new();
//
//        o.t = t;
//
//        try c.a.put(x, o);
//    }

    fn get(c: anytype, n: anytype) bool {

        var k: K = n;

        for (0..2) |z| {
            const m = c.b[z] + 1;

            if (k[z] > c.b[z]) k[z] %= m;
        }

        return c.a.l.contains(k);
    }

    fn deinit(c: anytype) void {
//        var a = c.a;

//        var i = a.valueIterator();
//
//        while (i.next()) |v| {
//            v.c.deinit();
//        }

        c.a.deinit();
        
//        c.b.deinit();
    }
};


//// Queue //
//const Q = struct {
//    n: N,
//    t: S,
//    f: N
//};


// Logic //
fn par(g: anytype, d: []u8) !C {

    var c = C.init(g);
//    try c.a.new();

    // Line //
    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        var k: [2]K = undefined;

        var i: u64 = 0;
        var ws = spl(l, "~");
        while (ws.next()) |w| {
            if (w.len == 0) continue;
            defer i += 1;

            var j: u64 = 0;
            var vs = spl(w, ",");
            while (vs.next()) |v| {
                if (v.len == 0) continue;
                defer j += 1;

                const z = try num(v, u64);

                k[i][j] = z;
            }
        }

        var q: Q = undefined;

        var s = true;

        for (0..3) |x| {

            q.k[x] = k[0][x];

            if (k[0][x] == k[1][x]) continue;

            assert(s);

            s = false;
            q.d = x;
            q.v = k[1][x];

            if (q.v < q.k[x]) swp(&q.v, &q.k[x]);

            assert(q.k[x] <= q.v);
        }

        if (s) {
            q.d = 0;
            q.v = q.k[0];
        }

        assert(q.k[2] > 0);

        q.k[2] -= 1;

        if (q.d == 2) q.v -= 1;
        
        try c.add(q);

// Map //
//        for (l, 0..) |v, j| {
//
//            k[1] = j;
//
////            if (j <= 0) continue;
//
//            switch (try dec(v)) {
//
//                T.R =>
//                    try c.add(k),
//                    
//                T.S =>
//                    c.p = k,
//                    
//                T.F => {
//                    for (0..2) |z| {
//                        if (k[z] > c.b[z]) c.b[z] = k[z];
//                    }
//                },
//            }                    
//        }
    }


// Offset //    
//    for (0..2) |z| {
//
//        const o = c.b[z] + 1;
//
//        while (c.p[z] < Z)
//            c.p[z] += o;
//    }

    return c;
}


// Run //
fn run(l: anytype, c: anytype, z: anytype) !u64 {

//    _ = l;

    // Loop control //
//    const d = 1;
    var d: u64 = D;
    var i: u64 = 0;


    // Debug //
    if (z > 0) {
        dbg.* = true;
        d = z;
    }

    prl();
    putd("  c", c.count());
    try san(c);


    // Timestamp //
    const t = tst();


    // Queue //
//    var q = Hash(K, void).init(l);
//    defer q.deinit();
//
//    try q.put(c.p, {});
//
//
//    // alt //
//    var n = Hash(K, void).init(l);
//    defer n.deinit();
//
//
//    // Visited //
//    var v = Hash(K, void).init(l);
//    defer v.deinit();


    // Result //
//    var r: [2]u64 = .{0, 0};
//    const r = if (z > 0) z else Z;

    var x: u64 = 1;

//    try pra(l, c);

    while (x > 0) {

        defer i += 1;
        x = 0;

        if (i % d == 0) {
            deb("\nrun", .{i+1, tst() - t});
        }

        const k = c.a.keys();

        for (k, 0..) |b, j| {

            if (try gra(c, k, b, j, 1)) {
            
//                prx("gra", j);
//                try pra(l, c);

                x += 1;
                break;
            }
        }

//        q.clearRetainingCapacity();
//        swp(&q, &n);
    }

    const k = c.a.keys();

//    try pra(l, c);

    prs("-----------------------------------------------------------");

    pr("\n  i: {any}\n", .{i-1});

    x = 0;

    for (k) |v| {

        const q = try dis(l, c, v);

        deb("q", q);

        x += q;
    }

    return x;        
}

fn san(
    c: anytype,

) !void {

    const k = c.a.keys();

    for (k, 0..) |x, j| {

        const n = x.k;
        const d = x.d;
    
        if (n[d] < x.v+1) {} else try err("san", .{j, x});
    }
}

fn prx(
    comptime m: anytype,
    j: anytype,

) void {

    const q = toc(j);

    putc(m, q);
}

fn toc(
    j: anytype

) u8 {

    const q: u8 = @intCast(j);
    return q + 'A';
}

fn dis(
    l: anytype,
    d: anytype,
    v: anytype,

) !u64 {

    var i = Hash(u64, void).init(l);
    defer i.deinit();

    var c = try d.clone();
    defer c.deinit();

    try c.remove(v);

    var x = true;

    while (x) {

        x = false;

        const k = c.a.keys();

        for (k, 0..) |b, j| {

            if (try gra(&c, k, b, j, 1)) {
            
                x = true;
                try i.put(j, {});

                break;
            }
        }
    }

    return i.count();
}

// x = ignore //
fn mov(
    a: anytype,
    x: anytype,
    b: anytype,
    i: anytype,

) !bool {

    if (b.k[2] <= 0) return false;

    var n = b;

    n.k[2] -= 1;

    if (b.d == 2) n.v -= 1;

    for (a, 0..) |o, j| {

        if (j == x) continue;
        if (j == i) continue;

        if (try col(n, o, false)) return false;
    }

    return true;
}

fn gra(
    c: anytype,
    a: anytype,
    b: anytype,
    i: anytype,
    z: u64

) !bool {

    if (b.k[2] < z) {

//        if (i == 0 and z == 1) return false;
//        try erx("bot", b, z, i, i, b, b);

        return false;
    }

    var n = b;

    n.k[2] -= z;

    if (n.d == 2) n.v -= z;

    for (a, 0..) |o, j| {

        if (i == j) continue;

        if (try col(n, o, false)) {

//            if (i == 1 and j == 0 and z == 1) return false;

//            try erx("yes", b, z, i, j, n, o);

            return false;

//        } else {
//
//            if (z >= 2) {
//
//                _ = try col(n, o, true);
//
//                try erx("noo", b, z, i, j, n, o);
//            }
        }
    }

    if (!try gra(c, a, b, i, z+1)) {

        // fail => move //
//        dpr("mov: {any} => {any}\n", .{b.k, n.k});

//        try erx("mov", b, z, i, i, n, n);

        try c.add(n);
        try c.remove(b);
    }

    return true;
}

fn erx(
    comptime m: anytype,
    b: anytype,
    z: anytype,
    i: anytype,
    j: anytype,
    n: anytype,
    o: anytype,

) !void {

    prl();

    deb("z", z);
    deb("b", b);

    prx("n", i);
    deb("n", n);

    prx("o", j);
    deb("o", o);

    try err(m, .{i, j});
}

fn col(
    x: anytype,
    y: anytype,
    g: anytype

) !bool {

    const n = x.k;
    const d = x.d;

    const o = y.k;

    var t = false;

    for (0..3) |i| {

        if (n[i] != o[i]) continue;

        var j, var k = try oth(i);

        for (0..2) |_| {

            if (d == j and n[d] <= o[d] and o[d] <= x.v) {

                const e = y.d;

                if (e == k and o[e] <= n[e] and n[e] <= y.v) return true;

                if (e == d and o[k] == n[k]) return true;
            }

            swp(&j, &k);
        }

        t = true;
    }

    if (!t) return false;

    var z = n;

    if (n[d] < x.v+1) {} else try err("x", x);

    for (n[d] .. x.v+1) |a| {

//        if (a % 10000 == 0) deb("a", a);

//        const e, const f = try oth(d);

        z[d] = a;

        if (try cll(y, z, g)) return true;
    }

    return false;
}

fn cll(
    y: anytype,
    n: anytype,
    w: anytype

) !bool {
    const o = y.k;
    const g = y.d;

    const e, const f = try oth(g);

    // o <- y //
    const r = (n[e] == o[e] and n[f] == o[f] and o[g] <= n[g] and n[g] <= y.v);

//    if (r or w) deb("cll", .{n, o, y.d, y.v, r});

    _ = w;
    
    return r;
}

fn oth(
    i: anytype,

) ![2]u64 {
    return switch(i) {
        0 => .{1, 2},
        1 => .{0, 2},
        2 => .{0, 1},

        else => return error.oth
    };
}

const S = Hash(K, u64);

fn cor(
    l: anytype,
    c: anytype,

) !S {
    var s = S.init(l);

    const k = c.a.keys();

    for (k, 0..) |b, j| {

        const n = b.k;
        const d = b.d;

        var z = n;

        for (n[d] .. b.v+1) |a| {

            z[d] = a;

            try s.put(z, j);
        }
    }

    return s;
}

fn pra(
    l: anytype,
    c: anytype,

) !void {

    if (!dbg.*) return;

    var s = try cor(l, c);
    defer s.deinit();

    var k: K = undefined;

    const m = c.b[2]+1;

    const e = ' ';

    for (0..2) |a| {

        prl();

        const b: usize = if (a == 0) 1 else 0;

        for (0 .. m+1) |zz| {

            const z = m - zz;

            dpr("  {d}| ", .{z+1});

            k[2] = z;

            for (0..c.b[a]+1) |x| {

                k[a] = x;

                var w: u8 = e;
            
                for (0..c.b[b]+1) |y| { 
               
                    k[b] = y;

                    if (s.get(k)) |v| {

                        const q = toc(v);

                        if (w != e and w != q) {

                            w = '?';
                            break;
                        }

                        w = q;
                    }
                }

                dpr("{c}", .{w});
            }

            prl();
        }

        prl();
    }
}


// Real Main //
fn rmain(l: anytype, nn: anytype) !void {
    prl();

    var n: u64 = nn;

    const f = "data" ++ aoc ++ suf ++ ".txt";

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) dbg.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Fake Main //
pub fn main() !void {

    // Fun! //
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const l = are.allocator();

    // Speed! //
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const l = gpa.allocator();

    try rmain(l, 0);
}


// Test! //
test "main" {
    dbg.* = true;

    prl();

    const l = std.testing.allocator;

    try rmain(l, D);
}
