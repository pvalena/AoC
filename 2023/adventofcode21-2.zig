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
const aoc = "21";
const suf = "-t";
const Z = 26501365;
const D = 5000;


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
const K = [2]u64;


// Data //
const A = genH(K);
//const B = gen2S(S);

const C = struct {
    a: A,
    p: K,
    b: K,

    l: mem.Allocator,

    fn init(l: anytype) C {
        var c: C = undefined;

        c.a = A.init(l);
//        c.b = try B.init(l);

        c.p = .{0, 0};
        c.b = .{0, 0};

        c.l = l;

        return c;
    }

//    fn new(c: anytype) M {
//        var m: M = undefined;
//
//        m.c = Array(N).init(c.l);
//
//        return m;
//    }

    fn add(c: anytype, v: anytype) !void {

        try c.a.add(v);
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
    try c.a.new();

    // split //
//    const s = " ->,";

    var i: u64 = 0;

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

        defer i += 1;

//        var j: u64 = 0;

        if (l.len == 0) continue;

        var k: K = .{i, 0};

        for (l, 0..) |v, j| {
//            if (w.len == 0) continue;

            k[1] = j;

//            if (j <= 0) continue;

            switch (try dec(v)) {

                T.R =>
                    try c.add(k),
                    
                T.S =>
                    c.p = k,
                    
                T.F => {
                    for (0..2) |z| {
                        if (k[z] > c.b[z]) c.b[z] = k[z];
                    }
                },
            }                    
        }

//        var n: N = undefined;
//        var ws = spl(l, s);
//        while (ws.next()) |w| {
//            if (w.len == 0) continue;
//
//            defer j += 1;
//
//            if (j <= 0) continue;
//
//            if (try dec(w, &m))
//            
//            try m.c.append(w);
//        }

//        try c.put(n, m);
    }

    
    for (0..2) |z| {

        const o = c.b[z] + 1;

        while (c.p[z] < Z)
            c.p[z] += o;
    }

    return c;
}

//fn dat(w: anytype, m: anytype) !N {
//
////    puts("dat; w", w);
//
//    m.t = try dec(w);
//
////    deb("dat; m.t", m.t);
//
//    if (m.t == T.B) return w;
//
//    return w[1..];
//}


fn run(l: anytype, c: anytype, z: anytype) !u64 {

//    _ = l;

    if (z > 0) {
        dbg.* = true;
    }


    // Loop control //
//    const d = 1;
    const d = 100;
    var i: u64 = 0;
    var j: u64 = 0;


    // Timestamp //
    const t = tst();


    // Queue //
    var q = Hash(K, void).init(l);
    defer q.deinit();

    try q.put(c.p, {});


    // alt //
    var n = Hash(K, void).init(l);
    defer n.deinit();


    // Visited //
    var v = Hash(K, void).init(l);
    defer v.deinit();


    // Result //
//    var r: [2]u64 = .{0, 0};
    const r = if (z > 0) z else Z;

    while (true) {
        defer i += 1;

        while (q.count() > 0) {

            if (j % d == 0) {
                prl();
                deb("run", .{j+1, q.count(), tst() - t});
//                pra(c, q);
//                prl();
            }

            defer j += 1;

            var k = q.keyIterator();

            while (k.next()) |s| {

                try v.put(s.*, {});

                try pla(c, s, &n);
            }

            q.clearRetainingCapacity();

            swp(&q, &n);

    //        _ = try fin(c);

            if (j >= r-1) break;
        }

        break;
    }

    pra(c, q);

    return q.count();
}

fn pla(
    c: anytype,
    s: anytype,
    n: anytype

) !void {

    const e = 2;

    for (0..e+1) |i| {
    for (0..e+1) |j| {

        if (i == 1 or j == 1) {} else continue;
        if (i == 1 and j == 1) continue;

        // borders //
        if (i <= 0 and s[0] <= 0) continue;
        if (j <= 0 and s[1] <= 0) continue;

        const k: K = .{i + s[0] - 1, j + s[1] - 1};

        for (0..2) |z|
            if (k[z] > c.b[z]) continue;

//        deb("pla", k);

        if (c.get(k)) continue;

//        deb("mov", k);

        try n.put(k, {});

    }}
}

fn pra(
    c: anytype,
    q: anytype,

) void {

    if (!dbg.*) return;

    const s = .{Z - c.b[0] - 1, Z - c.b[1] - 1};
    const e = .{c.b[1]+1 + Z + c.b[0], c.b[1]+1 + Z + c.b[1]};

    for (s[0]..e[0]) |i| {

        prl();
        prs("   ");

        for (s[1]..e[1]) |j| {

            const k = .{i, j};

            if (c.get(k)) {

                prs("#");

            } else {
                if (q.contains(k)) {

                    prs("O");

                } else {
                    prs(".");

                }
            }
        }
    }

    prl();
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
